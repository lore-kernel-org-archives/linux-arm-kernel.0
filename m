From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Jun 2016 09:55:25 -0700
Subject: [PATCH 2/2] arm: fix kernel image size
In-Reply-To: <20160621154407.GB5783@n2100.arm.linux.org.uk>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
 <E1bDzh4-0006a4-7p@e0050434b2927.dyn.armlinux.org.uk>
 <20160621074319.GH22406@atomide.com>
 <20160621094737.GA5783@n2100.arm.linux.org.uk>
 <20160621103810.GI22406@atomide.com>
 <20160621105720.GK22406@atomide.com>
 <20160621154407.GB5783@n2100.arm.linux.org.uk>
Message-ID: <20160621165523.GY22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [160621 08:46]:
> On Tue, Jun 21, 2016 at 03:57:20AM -0700, Tony Lindgren wrote:
> > 
> > Maybe zImage size + MAX_RODATA_SZ + 4x zImage size?
> > 
> > Then the MAX_RODATA_SZ could be 2 or 4 MB or whatever we
> > think is sufficient to kick the can until we have a better
> > solution.
> 
> Maybe if you give some details about your failing case - you omitted any
> details about the uncompressed image size...

Looks like we currently have this:

Memory: 2033088K/2095100K available (7376K kernel code, 784K rwdata,
2312K rodata, 1024K init, 8117K bss, 45628K reserved,
16384K cma-reserved, 1292284K highmem)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
    lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)
      .text : 0xc0008000 - 0xc0a762a4   (10681 kB)
      .init : 0xc0b00000 - 0xc0c00000   (1024 kB)
      .data : 0xc0c00000 - 0xc0cc411c   ( 785 kB)
       .bss : 0xc0cc6000 - 0xc14b37f8   (8118 kB)

Regards,

Tony
