From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Oct 2010 15:12:30 +0100
Subject: [PATCH] arm: omap: complete removal of
	machine_desc.io_pg_offst and .phys_io
In-Reply-To: <1287406656-24133-1-git-send-email-gadiyar@ti.com>
References: <1287406656-24133-1-git-send-email-gadiyar@ti.com>
Message-ID: <20101018141230.GD12449@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 18, 2010 at 06:27:36PM +0530, Anand Gadiyar wrote:
> Commit 861bd81ee6 in linux-next as of 20101018 (arm: remove
> machine_desc.io_pg_offst and .phys_io) missed out on updating
> a few boards. This causes the build of omap2plus_defconfig
> to fail. Fix this.

Not quite true.  The patch merged into my tree eliminates io_pg_offst and
phys_io for everything that is in my tree.

For new board support code which isn't in my tree, there is a problem -
patches to it can't be applied to my tree.

However, applying these patches to the trees which have the new code in
won't have the other changes related to the removal of io_pg_offst, and
so the support code will subtly break until it's all merged together.

There's two solutions to this.  One is to wait merging new board code
until after this merge window.  The other is to ensure that new board
code is in _my_ tree before the io_pg_offst changes were submitted...
