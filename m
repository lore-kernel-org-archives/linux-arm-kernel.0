From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 12 Jun 2013 09:45:13 +0200 (CEST)
Subject: [RFC PATCH 0/4] USB: HCD/EHCI: giveback of URB in tasklet context
In-Reply-To: <CACVXFVPRWxjXqyv-L6yU1OLXHFYCbe7cQxGnaFxqbEXwBK=hfQ@mail.gmail.com>
References: <CACVXFVMNzwD44mhKijURSWrqLKjy7_oOY8hrTtjbyOxGS2tv=g@mail.gmail.com>
 <Pine.LNX.4.44L0.1306111431170.1392-100000@iolanthe.rowland.org>
 <CACVXFVPRWxjXqyv-L6yU1OLXHFYCbe7cQxGnaFxqbEXwBK=hfQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1306120935320.22970@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013, Ming Lei wrote:
> On Wed, Jun 12, 2013 at 3:10 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> Also the tasklet running in CPU0 can handle the work which should
> >> have been done by the same tasket scheduled in CPU1,  so we can
> >> avoid busy-waitting in CPU1 which may be introduced by tasklet_schedule()
> >> in CPU1.
> >
> > Or you could have a separate tasklet for each host controller.
> 
> Yes, but I will compare tasklet with interrupt threaded handler first.

Yes, please. I read through the thread and I really recommend that you
get rid of the tasklet. tasklets are a complete disaster by design and
we really should make efforts to get rid of the last users instead of
trying to work around their semantical shortcomings.

Thanks,

	tglx
