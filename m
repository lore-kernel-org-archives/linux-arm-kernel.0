From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Jul 2012 09:14:28 +0800
Subject: [PATCH 1/2] ARM: i.MX6: set ARCH_NR_GPIO to 244
In-Reply-To: <5015624D.50305@googlemail.com>
References: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
 <20120728133215.GG2128@S2101-09.ap.freescale.net>
 <5015624D.50305@googlemail.com>
Message-ID: <20120730011426.GB30774@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 29, 2012 at 06:18:21PM +0200, Dirk Behme wrote:
> Hmm, sorry if I missed anything, but how is adding a 'default ..
> SOC_IMX6Q' related to any defconfig? If you want to deselect
> SOC_IMX6Q using the way you like you'll get the standard 256 (if I
> remember correctly).
> 
I'm essentially questioning about the point of the patch.  It intends
to save a little space for imx6q build without caring about imx3 and
imx5.  That said, when imx6q is excluded from the build, we are still
wasting those space.  That's why I'm not so excited about the patch.

Looking at current users of this definition, you will find all of them
are defining a number bigger than 256 for extending the maximum number.
It might be a sign that having a gpio array which is a little bigger
than necessary is not a concern on machines today.

-- 
Regards,
Shawn
