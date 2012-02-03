From: balbi@ti.com (Felipe Balbi)
Date: Fri, 3 Feb 2012 10:19:32 +0200
Subject: [RFC/PATCH] arm: omap3: pm: do not clear power states twice
In-Reply-To: <CAMQu2gwtXyLzPNk2_4O+EAWyZaQs+wY_cK4pm_=yJj6ARXnhAw@mail.gmail.com>
References: <1328254094-13978-1-git-send-email-balbi@ti.com>
 <CAMQu2gwtXyLzPNk2_4O+EAWyZaQs+wY_cK4pm_=yJj6ARXnhAw@mail.gmail.com>
Message-ID: <20120203081931.GF24297@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 01:34:55PM +0530, Shilimkar, Santosh wrote:
> On Fri, Feb 3, 2012 at 12:58 PM, Felipe Balbi <balbi@ti.com> wrote:
> > The way the code is written, pwrdm_pre_transion()
> > calls _pwrdm_pre_transition_cb() (for each powerdomain)
> > which, in turn, calls pwrdm_clear_all_prev_pwrst().
> >
> > It looks unnecessary to clear all previous power
> > states twice, so drop the initial set.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >
> > Hasn't been tested yet. Compile tested only. It looks
> > like we can safely remove those calls, but I would
> > like to hear from the PM folks first :-)
> >
> Bit late :)
> 
> Paul already cleaned this up.
> http://www.spinics.net/lists/linux-omap/msg63602.html

that's too bad. Missed an oportunity to have a commit on pm code, heh.
Anyway, thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120203/6b6d9108/attachment.sig>
