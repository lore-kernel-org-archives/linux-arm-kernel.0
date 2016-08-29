From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 23:10:57 +0800
Subject: [Patch v4 9/9] arm64: Update device tree for Layerscape SoCs
In-Reply-To: <20160829135130.GB28806@nazgul.tnic>
References: <1470780000-16750-1-git-send-email-york.sun@nxp.com>
 <20160812091354.GB333@nazgul.tnic> <20160829063448.GA32489@tiger>
 <20160829080530.GA25468@nazgul.tnic> <20160829083350.GL30790@tiger>
 <20160829135130.GB28806@nazgul.tnic>
Message-ID: <20160829151057.GY30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 03:51:30PM +0200, Borislav Petkov wrote:
> On Mon, Aug 29, 2016 at 04:33:50PM +0800, Shawn Guo wrote:
> > To avoid potential merge conflicts. 
> 
> Haven't heard of any so far. And I don't see how adding 1 or 2 DT
> entries more per driver is a serious merge conflict.

Yeah, the conflict might be just easy to resolve.  But it's still
annoying when upstream maintainer runs into it often.  Why don't we
avoid it to ease upstream maintainer's life when it's possible?

> 
> > Unless there are hard dependencies like making it compile, avoiding
> > regression or maintaining bisect, patches should go through their
> > established subsystem/architecture tree.
> 
> Well, doh, the driver simply doesn't work. How are people even supposed
> to test the EDAC tree?

People are not supposed to test EDAC tree in this case. linux-next tree
is born for that.

> Why is it even such a big deal if it is acked by the proper maintainers?
> Cross-tree maintainer acking happens all the time. So don't tell me the
> merge conflicts are your big issue with this.

It's not a big deal, and it happens all the time.  But we shouldn't
consider it as a recommended work flow.

> > Luckily.  If there are many patches on architecture DT branch changing
> > the same file, when driver branch and DT branch merges in upstream
> > branch, there will likely be merge conflicts.
> 
> So? There are tools to resolve those. And again, the DT changes for
> EDAC are basically adding blocks so resolving those conflicts should be
> trivial most of the time.

And again, I do not understand why we do so when there is a work flow to
avoid this.

> 
> So no, I don't consider the potential merge conflicts an issue here.

But I do.

If you really like to apply the DTS patch through EDAC tree, go ahead.
But I'm not going to ACK it, because I have an opinion that this merge
path is not really necessary.

Shawn
