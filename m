From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 17 Jul 2012 16:20:01 +0100
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <50057C1A.80606@linaro.org>
References: <5003FB7C.4030509@linaro.org>
 <20120717130650.GB27595@sirena.org.uk> <500568D9.10805@linaro.org>
 <20120717133550.GC4477@opensource.wolfsonmicro.com>
 <50057058.2060002@linaro.org>
 <20120717142222.GE4477@opensource.wolfsonmicro.com>
 <50057C1A.80606@linaro.org>
Message-ID: <20120717152001.GF4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 03:52:10PM +0100, Lee Jones wrote:

> I think it would be okay to take the 3 patches due for the v3.6
> merge window, which target the nmk-i2c driver. If any consolidation
> happens in the mean-time/future I will personally do the work to
> bring the nmk-i2c into line to use any generic bindings which
> result.

> No one else is ever going to use these vendor specific bindings, so
> I'm sure no issues will arise. It also means that we have a fully
> enabled driver which is capable of receiving a new configuration via
> minor changes to the dts, which is important for the current (only)
> user of this driver for an upcoming project.

So, this is pretty much what vendors always say about this stuff...

Looking at what's specified in the platform data in the current kernel
it seems like there's a mixture of things in there that are board and
silicon specific.  We've got parameters like the the speed mode and
timeout which are reasonably board specific but we've also got things
like the FIFO sizes which shouldn't be at all board specific and slsu
which really looks like it's something that that the driver ought to be
able to figure out for itself.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120717/364e24a2/attachment.sig>
