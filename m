From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 May 2015 14:23:02 +0200
Subject: [PATCH 3/6] pinctrl: sunxi: Add H3 PIO controller support
In-Reply-To: <5549EE36.4060603@gmail.com>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
 <1430904693-1404-4-git-send-email-jenskuske@gmail.com>
 <20150506101137.GB11057@lukather> <5549EE36.4060603@gmail.com>
Message-ID: <20150506122302.GF11057@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 12:34:30PM +0200, Jens Kuske wrote:
> >> +	SUNXI_PIN(SUNXI_PINCTRL_PIN(A, 6),
> >> +		  SUNXI_FUNCTION(0x0, "gpio_in"),
> >> +		  SUNXI_FUNCTION(0x1, "gpio_out"),
> >> +		  SUNXI_FUNCTION(0x2, "scr"),		/* PWREN */
> > 
> > The datasheet uses "SIM" for this, why have you changed the name here?
> 
> Thought I had changed that back. I first used scr because the
> responsible module is called scr everywhere else (clocks, memory map).
> Looks like I messed it up now and called the clocks "sim" instead...
> 
> I think I should also redo the dtsi and use scr for the clock again, to
> stay compatible with how it was called in Manual and earlier sunxi SoCs.

It seems reasonable :)

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150506/b855dfaf/attachment.sig>
