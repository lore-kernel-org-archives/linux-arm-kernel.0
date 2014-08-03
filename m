From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Aug 2014 21:41:43 +0100
Subject: Formal license ambiguity in arch/arm/boot/dts/sun?i-a*.dts
In-Reply-To: <20140803130430.GY3952@lukather>
References: <20140731192016.GA6869@excalibur.cnev.de>
 <20140803130430.GY3952@lukather>
Message-ID: <20140803204143.GD30282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 03, 2014 at 03:04:30PM +0200, Maxime Ripard wrote:
> From a quick grep, the issue is actually broader than just
> Allwinner. At least the following platforms seem to do the same:
>   - mvebu
>   - axm5516
>   - bcm
>   - berlin
>   - ea3250
>   - ecx-2000
>   - highbank
>   - imx / mxs
>   - lpc32xx
>   - phy3250
>   - picoxcell
>   - shmobile
>   - rockchip
>   - socfpga
>   - spear
>   - ste
>   - zynq
> 
> Would you mind sending a patch to fix all these?

A better question is whether they should even be solely under the GPL,
thereby preventing their use with other operating systems such as the
BSDs.

I feel that people haven't properly thought through the implications
with the DT files, and have just decided "the GPL is good enough for
the time being."  Well, if you have contributors to the DT files and
you later want to include them with other operating systems which are
not GPL licensed, then you have a problem.

I've tried bringing this up with Grant on a couple of occasions, and
so far I've been completely ignored.  I'm intending to place my
Cubox-i/Hummingboard DT files under the GPL and a non-GPL license
which allows their re-use elsewhere - I haven't decided what the
other license should be, but I'm considering the X11 license as that
allows the broadest re-use of the DT files.

As I see it, there is no "value" in restricting the DT files to be
GPL only and if others find them helpful to use elsewhere, then that's
what should happen.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
