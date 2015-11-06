From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Nov 2015 14:11:22 -0800
Subject: [PATCH 03/19] clk: sunxi: Add TCON channel0 clock
In-Reply-To: <CAGb2v66hjH_GpkXpHdpCM+mUv-CgvqxJNFzsoRJ5MWp04b+jew@mail.gmail.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-4-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66hjH_GpkXpHdpCM+mUv-CgvqxJNFzsoRJ5MWp04b+jew@mail.gmail.com>
Message-ID: <20151106221122.GL6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 31, 2015 at 06:19:59PM +0800, Chen-Yu Tsai wrote:
> > +#define SUN4I_A10_TCON_CH0_RESET_SHIFT 29
> 
> This is sun5i specific.
> 
> A10s manual says bit 30 is the LCD reset, while bit 29 is the TV
> encoder reset.  A13/R8 don't mention TCON_CH0 clock. A10/A20 have no
> separate TV encoder reset.
> 
> Please rename the clock.

This thing with the A10s is odd, the channel 0 is only used for the
LCD interface, and not the tv encoder (and both the A13 and R8 do have
a TCON).

But you're right, I've fixed it.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/a4d60d34/attachment.sig>
