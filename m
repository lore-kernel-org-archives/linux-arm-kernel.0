From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Mar 2012 12:33:22 +0000
Subject: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <20120306122516.GH17370@n2100.arm.linux.org.uk>
References: <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
 <4F53F704.8080703@freescale.com>
 <20120304232817.GA13516@n2100.arm.linux.org.uk>
 <4F53FBA1.8090200@freescale.com>
 <20120305000411.GL7363@n2100.arm.linux.org.uk>
 <4F54053F.9070502@freescale.com>
 <20120305002635.GA23798@opensource.wolfsonmicro.com>
 <20120306104015.GF17370@n2100.arm.linux.org.uk>
 <20120306120646.GH19635@opensource.wolfsonmicro.com>
 <20120306122516.GH17370@n2100.arm.linux.org.uk>
Message-ID: <20120306123322.GP19635@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 12:25:16PM +0000, Russell King - ARM Linux wrote:

> Please also note that in ALSA documentation, an 'atomic' callback means
> little with respect to race conditions.  All it means is that the callback
> is called from a context where sleeping in the callback is not permitted.
> The documentation does not say what is protected by the ALSA spinlocks and
> mutexes, so without reviewing the ALSA code, driver writters have little
> idea whether they need their own locks or not.

Well, who reads the documentation to get this stuff anyway?  As you
observe it's far from complete about what's what locked when and how so
you need to go to the code to see what's actually going on, especially
whenever you need to call back into the ALSA APIs.  Though of course I'm
pretty sure there's a bunch of uniprocessor assumptions through the body
of driver code anyway...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/43dc86f1/attachment.sig>
