From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Feb 2012 14:16:36 +0000
Subject: [PATCH v2 6/9] ARM: mx31ads: add audmux device
In-Reply-To: <20120202141124.GG9773@S2101-09.ap.freescale.net>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
 <20120202120900.GC7428@opensource.wolfsonmicro.com>
 <20120202131716.GF9773@S2101-09.ap.freescale.net>
 <20120202132618.GL7428@opensource.wolfsonmicro.com>
 <20120202141124.GG9773@S2101-09.ap.freescale.net>
Message-ID: <20120202141636.GB22048@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 10:11:26PM +0800, Shawn Guo wrote:
> On Thu, Feb 02, 2012 at 01:26:18PM +0000, Mark Brown wrote:

> > That's why I'm saying perhaps make it conditional on having ASoC built
> > (or even on having the AUDMUX driver built).

> Do you mean by having the below in some place like function
> imx31_soc_init()?

> #ifdef CONFIG_SND_MXC_SOC_AUDMUXV2
> 	imx_add_platform_device("audmux-v2", 0,
> 		audmux_res, ARRAY_SIZE(audmux_res), NULL, 0);
> #endif

Yes (you need to check for module too, there's a macro for that the name
of which escapes me right now).

> I do not think it's nice and consistent to the way that imx
> sub-architecture adds platform device.

Well, the i.MX thus far has had relatively few of these always present
type devices - it makes sense to make things conditional for devices
with external signals but for things entirely within the SoC the above
is less work.

> Furthermore, when a DT based board boots here, the code is broken.
> Explicitly adding the device by individual board as needed can easily
> align with DT based boards.  By default, the audmux node in <soc>.dtsi
> file has status = "disabled", and any board that needs audmux device
> only need to overwrite status property of audmux node as 'okay' in its
> <board>.dts.  Then DT core will add the audmux device when the board
> boots.

That seems like more work than is needed for boards, same issue applies.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/21058621/attachment.sig>
