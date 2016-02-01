From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Feb 2016 15:45:48 +0100
Subject: [linux-sunxi] Problem with Allwinner H3 clocks
In-Reply-To: <CAGb2v67AC+KO9mebyTosxSig7SzYm4Ovr5vCpEsX5N7YadJ-hw@mail.gmail.com>
References: <56A9098A.5010107@redhat.com>
 <20160127200217.14dce96ade71cf81bc82e6f6@free.fr>
 <56A9CE3D.4020906@redhat.com> <56AA14AA.4070502@gmail.com>
 <20160128175918.78a916a8cd7bf4c0b2f2814f@free.fr>
 <20160128192931.GB32462@lukather> <56AB05EF.2090604@redhat.com>
 <20160201063731.GG32462@lukather> <56AF6B23.1010901@redhat.com>
 <CAGb2v67AC+KO9mebyTosxSig7SzYm4Ovr5vCpEsX5N7YadJ-hw@mail.gmail.com>
Message-ID: <20160201144548.GD4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 10:37:45PM +0800, Chen-Yu Tsai wrote:
> >> There is, but it's opt-in, and we're not using it yet for anything but
> >> the hstimers (and in that case, we don't prevent the reclocking, we
> >> just take it into account).
> >
> > Shouldn't we be opt-ing in then ? At least the mmc driver makes
> > clk_set_rate calls, it would be bad if that somehow ends up changing the
> > pll6 rate while other peripherals are using it.
> 
> The mod clocks do not have CLK_SET_RATE_PARENT set, which prevents the
> CCF from propagating clk_set_rate to its parent. As is for the other
> child clocks of PLL6. The only exception is the SATA clock in PLL6.

The PLL6 you're talking about is not the PLL6 we're talking about ;)

We're talking about the A31's, while the SATA on the A10 / A20 is
driven by the A10's (the equivalent for the A10 would be the PLL5)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/3321040e/attachment.sig>
