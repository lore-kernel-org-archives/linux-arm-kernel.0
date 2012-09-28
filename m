From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 28 Sep 2012 14:12:54 +0100
Subject: [GIT PULL] ARM: cache flushing LoUIS API v2
In-Reply-To: <20120928125446.GF7916@n2100.arm.linux.org.uk>
References: <20120928092123.GA28967@e102568-lin.cambridge.arm.com>
 <20120928125446.GF7916@n2100.arm.linux.org.uk>
Message-ID: <20120928131254.GB30058@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 01:54:46PM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 28, 2012 at 10:21:23AM +0100, Lorenzo Pieralisi wrote:
> > The following changes since commit 979570e02981d4a8fc20b3cc8fd651856c98ee9d:
> > 
> >   Linux 3.6-rc7 (2012-09-23 18:10:57 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://linux-arm.org/linux-2.6-lp.git cache-louis
> 
> Okay, so this is where things fall apart.  My devel-*stable* branch now
> contains this after re-pulling:
> 
> 75c530d Merge branch 'cache-louis' of git://linux-arm.org/linux-2.6-lp into devel-stable
> 94966a2 ARM: mm: update __v7_setup() to the new LoUIS cache maintenance API
> 934ce49 ARM: kernel: update __cpu_disable to use cache LoUIS maintenance API
> afd9219 ARM: kernel: update cpu_suspend code to use cache LoUIS operations
> a66b3e1 ARM: mm: rename jump labels in v7_flush_dcache_all function
> eee5d28 ARM: mm: implement LoUIS API for cache maintenance ops
> e3ef0dc Merge branch 'cache-louis' of git://linux-arm.org/linux-2.6-lp into devel-stable
> 6323fa2 ARM: mm: update __v7_setup() to the new LoUIS cache maintenance API
> e6b866e ARM: kernel: update __cpu_disable to use cache LoUIS maintenance API
> dbee0c6 ARM: kernel: update cpu_suspend code to use cache LoUIS operations
> 3287be8 ARM: mm: rename jump labels in v7_flush_dcache_all function
> 031bd87 ARM: mm: implement LoUIS API for cache maintenance ops
> 
> Can you spot the problem?  Remember, devel-*stable* is supposed to
> be guaranteed never to be rewound or rebased after it's published (and
> it has been.)

Ok, understood, sorry. What's the best way forward then ?

Should I add the fix for xscale and feroceon to your patch system ?

Lorenzo
