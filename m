From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 19 Jun 2013 15:17:36 -0300
Subject: [PATCH v3 05/12] ARM: mvebu: Remove the harcoded BootROM window
 allocation
In-Reply-To: <20130619180320.GA25000@obsidianresearch.com>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130618173906.GC2204@obsidianresearch.com>
 <20130619100159.GB16138@localhost>
 <20130619165834.GB32155@obsidianresearch.com>
 <20130619175823.GB2324@localhost>
 <20130619180320.GA25000@obsidianresearch.com>
Message-ID: <20130619181735.GA5701@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 12:03:20PM -0600, Jason Gunthorpe wrote:
> On Wed, Jun 19, 2013 at 02:58:24PM -0300, Ezequiel Garcia wrote:
> 
> > I wasn't sure you wanted to panic(), to clip on available CPUs,
> > or to just do a pr_warn / WARN(), so here's a piece of code:
> > (disclaimer: non-tested, non-compiled, etc.)
> 
> Up to you, but you know it won't work if it isn't right so continuing
> on to try and startup the CPUs is not ideal. panic is probably
> reasonable?
>  

Well, the other CPUs don't start but the system itself does not die,
(or at least that's the case on my systems).

It's up to you, I'm fine with either, although I'm inclined to just
panic.

> > 	node = of_find_compatible_node(NULL, NULL, "bootrom");
> 
> "marvell,bootrom" ?
> 

Yes, indeed.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
