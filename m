From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 25 Feb 2012 11:39:03 +0000
Subject: [PATCH 6/6] ASoC: fsl: check property 'compatible' for the
 machine name
In-Reply-To: <4F47BB0D.9080905@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
 <20120224141207.GI5450@opensource.wolfsonmicro.com>
 <4F47BB0D.9080905@freescale.com>
Message-ID: <20120225113902.GA3167@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 10:30:05AM -0600, Timur Tabi wrote:
> Mark Brown wrote:
> > The ARM machines really shouldn't be using the bindings that PowerPC is
> > using for the machine as they conflate the machine driver with the SSI
> > binding.  The idiom for new systems is that machine drivers should be
> > first class devices in the device tree referencing the SSI and CODEC.

> Where is this documented?

> I don't remember participating in the discussion for this new binding.

It's not a specific binding but rather a general idea of how these
bindings should be done - I don't know how one would go about
documenting general ideas like that, I have asked people to do that but
I don't think there's a mechanism.  There's a couple of such bindings in
mainline at present (the nVidia ones).

I do recall you being involved in some of the discussions, though it's
possible I have these confused with other device tree threads.

> > The current bindings should be preserved for existing systems of course.

> There's no reason we can't update the PowerPC device trees.

We could, yes, but it would make people's existing device trees buggy
which would be sad.  It'd be nicer to keep the old binding around and
support it for people who are already using it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120225/be8b9fec/attachment-0001.sig>
