From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 9 Mar 2012 11:59:59 +0000
Subject: [PATCH v3 00/11] ASoC: add imx-sgtl5000 machine driver working
 with fsl_ssi
In-Reply-To: <20120309071347.GM2499@S2101-09.ap.freescale.net>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <4F5910EE.8090408@freescale.com>
 <20120309011914.GF2499@S2101-09.ap.freescale.net>
 <4F5966DC.6090201@freescale.com>
 <20120309071347.GM2499@S2101-09.ap.freescale.net>
Message-ID: <20120309115956.GF3273@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2012 at 03:13:49PM +0800, Shawn Guo wrote:

> My bisect tells that the offending commit is:

>   96acc35 (ASoC: DAPM: Make sure DAPM widget IO ops hold the component mutex)

> But I do not understand why yet.

It'll be deadlocking somewhere I expect - turning on the soft lockup
detector will probably make it obvious.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120309/33c86013/attachment-0001.sig>
