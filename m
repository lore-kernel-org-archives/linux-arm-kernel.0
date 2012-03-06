From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Mar 2012 12:06:47 +0000
Subject: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
In-Reply-To: <20120306104015.GF17370@n2100.arm.linux.org.uk>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
 <4F53F704.8080703@freescale.com>
 <20120304232817.GA13516@n2100.arm.linux.org.uk>
 <4F53FBA1.8090200@freescale.com>
 <20120305000411.GL7363@n2100.arm.linux.org.uk>
 <4F54053F.9070502@freescale.com>
 <20120305002635.GA23798@opensource.wolfsonmicro.com>
 <20120306104015.GF17370@n2100.arm.linux.org.uk>
Message-ID: <20120306120646.GH19635@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 10:40:15AM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 05, 2012 at 12:26:36AM +0000, Mark Brown wrote:
> > On Mon, Mar 05, 2012 at 12:13:52AM +0000, Tabi Timur-B04825 wrote:

> > > To answer your question: I was lead to believe that the individual ALSA 
> > > callback functions are atomic.  So one thread should not be trying to 
> > > start playback while another thread is simultaneously trying to stop it.

> > That's correct, there's ALSA level locking.

> Please explain which lock prevents the capture substream trigger callback
> occuring simultaneously with a playback substream trigger callback on a
> SMP system.

Oh, bother - that one is per substream not per stream.  Which isn't
terribly helpful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/4cb0f073/attachment.sig>
