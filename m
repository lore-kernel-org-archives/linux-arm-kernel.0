From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 06 Apr 2012 18:43:30 -0700
Subject: [PATCH v2 13/13] ARM: at91: dt: remove unit-address part for
 memory nodes
In-Reply-To: <20120404191754.GE10603@quad.lixom.net>
References: <cover.1333437885.git.nicolas.ferre@atmel.com>
 <1db62b280314855c35cb7a3188fc9d9cb8501948.1333437885.git.nicolas.ferre@atmel.com>
 <20120404191754.GE10603@quad.lixom.net>
Message-ID: <20120407014330.B6D4E3E22DF@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Apr 2012 12:17:54 -0700, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Apr 03, 2012 at 09:32:57AM +0200, Nicolas Ferre wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> > 
> > Having a unit-address different from 0 causes bad memory node detection
> > during early_init_dt_scan_memory.
> 
> Sounds like a bug in the generic code to me? But specifying a unit
> address on a non-ambiguous device node isn't necessary anyway, so this
> patch is still a reasonable thing to do.

It's actually a 'feature' of the way we're including skeleton.dtsi.
skeleton.dtsi has already set the node name, so if the next file
doesn't use exactly the same node name then the .dtb ends up with two
memory nodes, which is really bad.

It real problem is the dtc tooling.

g.
