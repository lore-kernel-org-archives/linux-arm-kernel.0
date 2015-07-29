From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Jul 2015 10:25:37 +0100
Subject: [PATCH 0/2] arm64: support initrd outside of mapped RAM
In-Reply-To: <1438161638.3129.4.camel@linaro.org>
References: <1438093961-15536-1-git-send-email-msalter@redhat.com>
 <1438161638.3129.4.camel@linaro.org>
Message-ID: <20150729092536.GI15213@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 10:20:38AM +0100, Jon Medhurst (Tixy) wrote:
> On Tue, 2015-07-28 at 10:32 -0400, Mark Salter wrote:
> > When booting an arm64 kernel w/initrd using UEFI/grub, use of mem= will likely
> > cut off part or all of the initrd. This leaves it outside the kernel linear
> > map which leads to failure when unpacking.
> 
> Have we got a similar issue for the device-tree blob?

Commit 61bd93ce801bb6df ("arm64: use fixmap region for permanent FDT
mapping") [1] solved that for the DTB in v4.2-rc1.

Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=61bd93ce801bb6df36eda257a9d2d16c02863cdd
