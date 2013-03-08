From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 8 Mar 2013 13:05:50 -0700
Subject: [PATCH 04/10] bus: introduce an Marvell EBU MBus driver
In-Reply-To: <201303081942.27233.arnd@arndb.de>
References: <1362577426-12804-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303081541.29410.arnd@arndb.de>
 <20130308175023.GE4094@obsidianresearch.com>
 <201303081942.27233.arnd@arndb.de>
Message-ID: <20130308200550.GD29435@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 07:42:27PM +0000, Arnd Bergmann wrote:
> > An absent ranges makes some sense from a spec perspective - however do we
> > have the kernel infrastructure to grow an in memory DTB node?
> 
> I don't think it's necessary to amend the flattened DT in the DTB form,
> although that could be done if necessary. Once we have the live DT data
> structures, after calling unflatten_device_tree(), we can trivially call
> of_add_property() to add the ranges.

Oh, I've never looked at those APIs, that makes it pretty nice,
indeed. With those it would be easy to keep the in-memory DT in sync.

The only other problem with absent ranges is how do you learn the
target id and size to do the assignment?

> devices from the tree. If we need any of the MBUS children before
> initcalls, we can also move that stage earlier and set up the mbus
> windows from the machine_init callback.

Yah, technically the interrupt controller and timer should be below
the mbus block.

Cheers,
Jason
