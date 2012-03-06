From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Mar 2012 16:54:27 +0000
Subject: [alsa-devel] [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
In-Reply-To: <20120306135259.GJ17370@n2100.arm.linux.org.uk>
References: <20120305000411.GL7363@n2100.arm.linux.org.uk>
 <4F54053F.9070502@freescale.com>
 <20120305002635.GA23798@opensource.wolfsonmicro.com>
 <20120306104015.GF17370@n2100.arm.linux.org.uk>
 <20120306120646.GH19635@opensource.wolfsonmicro.com>
 <20120306122516.GH17370@n2100.arm.linux.org.uk>
 <20120306123322.GP19635@opensource.wolfsonmicro.com>
 <s5h4nu17tdn.wl%tiwai@suse.de>
 <20120306133818.GV19635@opensource.wolfsonmicro.com>
 <20120306135259.GJ17370@n2100.arm.linux.org.uk>
Message-ID: <20120306165427.GY19635@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2012 at 01:52:59PM +0000, Russell King - ARM Linux wrote:

> Stop using the term "uniprocessor assmptions".

> Thinking that something is safe because you're running on a uniprocessor
> system is total bollocks at every level.

Feh, it's hardly a new term - it dates back to when those crazy x86 kids
first got their hands on this fancy new SMP stuff and started running
into issues.  It's coming from the fact that that was the first case to
change the assumptions that had previously existed so things broke on
SMP systems.

> What you mean is "single threaded assumptions".  Please use this term
> instead - it's what you actually mean.

If we're concerned about the name I'd not mention threads as that's
often confusing for people in these contexts as it's not always obvious
to everyone if or how interrupts count.  "Single execution context" or
even "old school Linux" are probably less ambiguous.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120306/9992ea5b/attachment.sig>
