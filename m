From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 16:33:50 +0800
Subject: [Patch v4 9/9] arm64: Update device tree for Layerscape SoCs
In-Reply-To: <20160829080530.GA25468@nazgul.tnic>
References: <1470780000-16750-1-git-send-email-york.sun@nxp.com>
 <20160812091354.GB333@nazgul.tnic> <20160829063448.GA32489@tiger>
 <20160829080530.GA25468@nazgul.tnic>
Message-ID: <20160829083350.GL30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 10:05:30AM +0200, Borislav Petkov wrote:
> On Mon, Aug 29, 2016 at 02:34:48PM +0800, Shawn Guo wrote:
> > Is it mandatory to have DTS changes go with driver part altogether?
> 
> Yes, because the EDAC driver needs them to even load properly.

When separate branches get merged on Linus tree, it works anyway.

> 
> > Otherwise, I prefer to have them go through separate tree.
> 
> Any particular reason why you prefer that?

To avoid potential merge conflicts.  Unless there are hard dependencies
like making it compile, avoiding regression or maintaining bisect,
patches should go through their established subsystem/architecture tree.

> We've been doing this for other ARM EDAC drivers already and there were
> no issues whatsoever.

Luckily.  If there are many patches on architecture DT branch changing
the same file, when driver branch and DT branch merges in upstream
branch, there will likely be merge conflicts.

Shawn
