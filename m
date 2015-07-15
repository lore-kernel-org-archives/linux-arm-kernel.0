From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 15 Jul 2015 15:23:07 +0800
Subject: [PATCH][v3] ARM: imx: pinctrl-imx: imx7d: add support for iomuxc
 lpsr
In-Reply-To: <1436295725-19011-1-git-send-email-aalonso@freescale.com>
References: <1436295725-19011-1-git-send-email-aalonso@freescale.com>
Message-ID: <20150715072307.GM4119@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 02:02:05PM -0500, Adrian Alonso wrote:
> * Extend pinctrl-imx driver to support iomux lpsr conntroller,
> * iMX7D has two iomuxc controllers, iomuxc controller similar as
>   previous iMX SoC generation and iomuxc-lpsr which provides
>   low power state rentetion capabilities on gpios that are part of
>   iomuxc-lpsr (GPIO1_IO7..GPIO1_IO0).
> * Use IOMUXC_LPSR_SUPPORT and iput_val most significant bits to
>   properly configure iomuxc/iomuxc-lpsr settings.
> 
> Signed-off-by: Adrian Alonso <aalonso@freescale.com>

It took me quite some time to understand what the patch does.  Before I
gave specific comments on your implementation, I would discuss if there
is a better solution, as I do not like the idea of encoding these
artificial pin id of LPSR pads in the input_val.

Ideally, the LPSR controller should be implemented as a second instance
of IOMUXC.  But the problem seems to be the select input register is
shared between these two instances.  Is my understanding correct?

How select input register is shared?  With different bits in a single
register which is only laid on normal IOMUXC controller?

I need more details to understand the problem.

Shawn
