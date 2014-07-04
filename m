From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 4 Jul 2014 09:22:43 +0200
Subject: [PATCH] pinctrl: sunxi: Fix multi bank interrupt support in
 gpio_to_irq
In-Reply-To: <CAGb2v67ZNsq9J1Fs3uURJbDPvCvPUDm6rYXq=FfuZCAo1HtaRQ@mail.gmail.com>
References: <1404144299-740-1-git-send-email-wens@csie.org>
 <20140704070355.GI31996@lukather>
 <CAGb2v67ZNsq9J1Fs3uURJbDPvCvPUDm6rYXq=FfuZCAo1HtaRQ@mail.gmail.com>
Message-ID: <20140704072243.GK31996@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 03:11:04PM +0800, Chen-Yu Tsai wrote:
> On Fri, Jul 4, 2014 at 3:03 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Tue, Jul 01, 2014 at 12:04:59AM +0800, Chen-Yu Tsai wrote:
> >> When mapping the interrupts, the gpio_to_irq function did not consider
> >> the bank number of the gpio pin in question, only the offset or the
> >> interrupt number in the bank. As a result, requests for interrupts in
> >> the later banks get mapped to the first bank.
> >>
> >> This issue was discovered while enabling mmc on the new sun8i platform.
> >> The tablet I have uses a pin/interrupt from the second bank to do mmc
> >> card detection. Tested on this very device with register inspection and
> >> actual mmc card insertion/removal.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >
> > Linus, could this be merged as a fix for 3.16?
> 
> Aren't your multi-bank external interrupt patches queued for 3.17?
> This patch applies over them.

Ah, yes, you're right.

Sorry for the noise :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140704/bc1b6b4d/attachment.sig>
