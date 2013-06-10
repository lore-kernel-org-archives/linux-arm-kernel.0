From: oliver@neukum.org (Oliver Neukum)
Date: Mon, 10 Jun 2013 11:31:15 +0200
Subject: [RFC PATCH 1/4] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <CACVXFVPs-MJy595OyqMs9rNmNAqcU7JDHXp+yp5bnEdq7_M-fg@mail.gmail.com>
References: <1370791112-18464-1-git-send-email-ming.lei@canonical.com>
 <1399422.br9htUau7f@linux-5eaq.site>
 <CACVXFVPs-MJy595OyqMs9rNmNAqcU7JDHXp+yp5bnEdq7_M-fg@mail.gmail.com>
Message-ID: <10081846.6daPCXpZuS@linux-5eaq.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 June 2013 17:23:46 Ming Lei wrote:
> On Mon, Jun 10, 2013 at 4:43 PM, Oliver Neukum <oliver@neukum.org> wrote:
> > On Sunday 09 June 2013 23:18:28 Ming Lei wrote:
> >> 2), the biggest change is the situation in which usb_submit_urb() is called
> >> in complete() callback, so the introduced tasklet schedule delay might be a
> >> con, but it shouldn't be a big deal:
> >>
> >>         - control/bulk asynchronous transfer isn't sensitive to schedule
> >>           delay
> >
> > That is debatable.Missing a frame boundary is expensive because the increased
> > latency then translates into lower throughput.
> 
> Suppose so, considered that bulk transfer will do large data block transfer, and
> the extra frame or uFrame doesn't matter over the whole transfer time.

That is not true for all use cases. Networking looks vulnerable.

	Regards
		Oliver
