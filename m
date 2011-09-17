From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 17 Sep 2011 23:14:07 +0800
Subject: [PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
	initialization functions
In-Reply-To: <20110917104518.GD16381@n2100.arm.linux.org.uk>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
	<1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
	<20110914084237.GC6267@n2100.arm.linux.org.uk>
	<20110915013937.GE1488@S2100-06.ap.freescale.net>
	<20110915083248.GG6267@n2100.arm.linux.org.uk>
	<CAGsJ_4xpc-8zzGkZ9LThqP7in27n6uX4LRGAf+AtoWTM4p=82w@mail.gmail.com>
	<20110917104518.GD16381@n2100.arm.linux.org.uk>
Message-ID: <20110917151405.GA26716@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2011 at 11:45:18AM +0100, Russell King - ARM Linux wrote:
> I'm now starting to think that we don't actually want any resume code
> at the L2 level - most SoCs will be operating in non-secure mode (I
> believe it's only ARM's development platforms which operate in secure
> mode)

On imx6q, I can program PL310 without SMC call at resume entry, which
probably means imx6q is a SoC operating in secure mode.

Regards,
Shawn

> and so most of the generic code which will need to write to the
> L2 control registers on resume will fail.
