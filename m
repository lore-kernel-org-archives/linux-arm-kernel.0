From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 9 Mar 2012 09:32:17 +0800
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F591B8D.8090705@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
Message-ID: <20120309013216.GH2499@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 02:50:21PM -0600, Timur Tabi wrote:
> Shawn Guo wrote:
> > As Documentation/devicetree/bindings/powerpc/fsl/ssi.txt documented,
> > codec-handle is an optional property, so missing it should not be a
> > fatal error.]
> 
> It's optional in the sense that if your SSI is not connected to anything,
> then you don't need to specify the codec handle.  If the SSI is connected
> to a codec, then the SSI node needs to point to it.
> 
It's true for the binding that mpc8610_hpcd and p1022_ds use.  But per
request from Mark, we need to use the new binding for imx machine
drivers, which will have the codec phandle in "audio complex" node.

> > More importantly, the imx machine drivers to be added working with
> > fsl_ssi will not have this property, as they use new ASoC machine
> > driver binding mechanism.
> 
> I want to see that binding documented in Documentation/devicetree/bindings
> first.

Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt, which
takes Documentation/devicetree/bindings/sound/tegra-audio-wm8903.txt
as the example.

-- 
Regards,
Shawn
