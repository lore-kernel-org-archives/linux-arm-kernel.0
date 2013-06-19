From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 19 Jun 2013 10:58:34 -0600
Subject: [PATCH v3 05/12] ARM: mvebu: Remove the harcoded BootROM window
 allocation
In-Reply-To: <20130619100159.GB16138@localhost>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130618173906.GC2204@obsidianresearch.com>
 <20130619100159.GB16138@localhost>
Message-ID: <20130619165834.GB32155@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 07:02:00AM -0300, Ezequiel Garcia wrote:

> > Verifying the DT is setup this way and aborting if it is not seems
> > like a good idea..
> 
> I agree it's a nice idea, but I'm not too sure how to accomplish this
> in a simple and generic way. There's nothing in the DT that allows you
> to know which of the ranges entries correspond to the BootROM, unless you go
> through each of the entries comparing against the known target ID and
> attribute.

I think you need to have a defined compatible string for the bootrom,
use one of the of_find.. functions to locate the node, then translate
the regs to get a CPU address, ensure it is the right base and size..

> You could also do a 'of_find_node_by_name(NULL, "bootrom");' but the
> binding no longer requires to even have any children for the window.

You'll need to define a bootrom binding. There is not a lot of sense
in including things in the DT if the kernel can't find them and use
them.

Jason
