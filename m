From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 29 Nov 2012 14:30:41 +0000
Subject: [PATCH V7 3/7] arm64: use new common dtc rule
In-Reply-To: <1354058956-7199-3-git-send-email-swarren@wwwdotorg.org>
References: <1354058956-7199-1-git-send-email-swarren@wwwdotorg.org>
 <1354058956-7199-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121129143041.GC30437@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 11:29:12PM +0000, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The current rules have the .dtb files build in a different directory
> from the .dts files. This patch changes arm64 to use the generic dtb
> rule which builds .dtb files in the same directory as the source .dts.
> 
> This requires moving parts of arch/arm64/boot/Makefile into newly created
> arch/arm64/boot/dts/Makefile, and updating arch/arm64/Makefile to call the
> new Makefile.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

I had a bit more clean-up in a local patch (see attached). Depending on
the timing, you can just fold it into your patch (basically removing the
MACHINE argument, adding KBUILD_DTBS and dtbs target help). It's been
derived from your arch/arm patch anyway ;).

-- 
Catalin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-arm64-Add-dtbs-target-for-building-all-the-enabled-d.patch
Type: text/x-diff
Size: 2975 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121129/742bd030/attachment.bin>
