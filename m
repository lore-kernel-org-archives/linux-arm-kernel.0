From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Apr 2017 16:49:09 +0100
Subject: [PATCH 6/6] regulator: anatop: set default voltage selector for
 pcie
In-Reply-To: <20170413074103.GC23163@b29396-OptiPlex-7040>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
 <1491962327-12477-6-git-send-email-aisheng.dong@nxp.com>
 <20170411204003.avoe5a6o52kx5on2@sirena.org.uk>
 <20170413074103.GC23163@b29396-OptiPlex-7040>
Message-ID: <20170412154909.hhv3kexadbqsekkr@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 13, 2017 at 03:41:03PM +0800, Dong Aisheng wrote:
> On Tue, Apr 11, 2017 at 09:40:03PM +0100, Mark Brown wrote:

> > Why is this the only anatop regulator which can have this problem and
> > how do we know this is a good value?

> Anatop regulator has no separate gate bit.
> e.g.
> 00000 Power gated off
> 00001 Target core voltage = 0.725V
> ...
> So it may have no valid default voltage in case it's disabled in
> bootloader.
> e.g. regulator_enable() may not work.

That doesn't answer my question.  What I'm asking is why another anatop
regulator might not end up disabled like this one.

> The default voltage 1.100v this patch sets is defined in reference
> manual.

For the SoC you're currently looking at...  might another have a
different value?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170412/80fac801/attachment.sig>
