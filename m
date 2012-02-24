From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 24 Feb 2012 14:12:07 +0000
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120224141207.GI5450@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 10:09:41PM +0800, Shawn Guo wrote:
> The fsl_ssi probe function detects the client machine name using model
> property of the device tree.  But it will not work for the ARM client
> machines which are to be added.  The model property is given as a
> descriptive string on all ARM device tree (arch/arm/boot/*.dts).
> Instead, the compatible property gives the machine name.

The ARM machines really shouldn't be using the bindings that PowerPC is
using for the machine as they conflate the machine driver with the SSI
binding.  The idiom for new systems is that machine drivers should be
first class devices in the device tree referencing the SSI and CODEC.

The current bindings should be preserved for existing systems of course.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120224/e1f0c88e/attachment.sig>
