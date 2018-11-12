From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 12 Nov 2018 11:49:54 +0800
Subject: [PATCH v1 3/3] arm64: dts: mt7622: Drop the general purpose
 timer node
In-Reply-To: <1541993608.30437.3.camel@mtkswgap22>
References: <30f4a4110190a175307ac4dfebc98ffe96c44b90.1541643419.git.ryder.lee@mediatek.com>
 <17fde639c7d37f9cfabab230379913e652cf869a.1541643419.git.ryder.lee@mediatek.com>
 <20181112024556.GI2642@sasha-vm> <1541993608.30437.3.camel@mtkswgap22>
Message-ID: <1541994594.31175.4.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-11-12 at 11:33 +0800, Ryder Lee wrote:
> On Sun, 2018-11-11 at 21:45 -0500, Sasha Levin wrote:
> > On Mon, Nov 12, 2018 at 09:28:08AM +0800, Ryder Lee wrote:
> > >The crash http://termbin.com/zitb is caused by the timer register
> > >into system in early pahse during kernel boot, but the clock
> > >sources didn't get ready at that time.
> > >
> > >A better way is to switch to use CLK_OF_DECLARE() in driver for things
> > >that need them early, but this node is actually useless in MT7622.
> > >So we drop it.
> > >
> > >Fixes: 9cc7f0de9e67 ("arm64: dts: mt7622: add timer, CCI-400 and PMU nodes")
> > >Cc: stable at vger.kernel.org
> > >Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > 
> > To confirm: the patch this fixes was added in v4.20-rc1, which means
> > that this current patch doesn't apply to any of the stable trees.
> > 
> > Did we miss something?
> > 
> 
> I didn't see any fixup for this?
> 
> Ryder

Oh, I didn't get it right. Yes, there is no need to apply to the stable
trees.

@Matthias, could you help to drop the CC tag when you take this patch
through your tree?

Sorry for the inconvenience.

Thanks
Ryder
