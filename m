From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Aug 2013 23:43:53 +0100
Subject: [PATCH V2] ARM: allow DEBUG_UNCOMPRESS for Tegra
In-Reply-To: <520BF6F5.5090303@wwwdotorg.org>
References: <1375379471-15615-1-git-send-email-swarren@wwwdotorg.org>
 <520BF6F5.5090303@wwwdotorg.org>
Message-ID: <20130814224353.GZ23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 03:30:29PM -0600, Stephen Warren wrote:
> On 08/01/2013 11:51 AM, Stephen Warren wrote:
> > From: Stephen Warren <swarren@nvidia.com>
> > 
> > DEBUG_UNCOMPRESS was previously disallowed for Tegra due to tegra.S's
> > use of global data that was not linked into the decompressor. Solve this
> > by declaring this symbol in tegra.S when it is being built into the
> > decompressor. For the kernel proper, leave the declaration in
> > mach-tegra/common.c as explained in the comment.
> > 
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > ---
> > v2: Don't select DEBUG_UNCOMPRESS with DEBUG_TEGRA_UART unless
> >     !ZBOOT_ROM. Add notes on ZBOOT_ROM to comment.
> > 
> > Russell, I assume this should go in through the ARM patch tracker. Or,
> > do you want me to take it through the Tegra tree?
> 
> Russell, I put this patch into the ARM patch tracker a while back. I
> assume it's something you plan to take, or should I put it into the
> Tegra tree? Thanks.

I haven't applied it yet because it doesn't apply to the branch it needs
to (that being the debug choice cleanup):

Patching 7806/1...
git apply --whitespace=fix -p1 --index --check > /tmp/pdb.12252 2>&1 exited with non-zero status: 256
error: patch failed: arch/arm/Kconfig.debug:1052
error: arch/arm/Kconfig.debug: patch does not apply

Not even with gnu patch:

patching file arch/arm/Kconfig.debug
Hunk #1 FAILED at 1052.
1 out of 1 hunk FAILED -- saving rejects to file arch/arm/Kconfig.debug.rej
patching file arch/arm/include/debug/tegra.S

This is because at the moment, that branch is based before other
changes which have gone in during the -rcs, namely b6992fa9a7.  It
needs that branch rebased before it can be applied.  I'll get to it
eventually.
