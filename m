From: timur@freescale.com (Timur Tabi)
Date: Thu, 8 Mar 2012 14:50:21 -0600
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F591B8D.8090705@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> As Documentation/devicetree/bindings/powerpc/fsl/ssi.txt documented,
> codec-handle is an optional property, so missing it should not be a
> fatal error.]

It's optional in the sense that if your SSI is not connected to anything,
then you don't need to specify the codec handle.  If the SSI is connected
to a codec, then the SSI node needs to point to it.

> More importantly, the imx machine drivers to be added working with
> fsl_ssi will not have this property, as they use new ASoC machine
> driver binding mechanism.

I want to see that binding documented in Documentation/devicetree/bindings
first.

-- 
Timur Tabi
Linux kernel developer at Freescale
