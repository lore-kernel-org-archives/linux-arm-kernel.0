From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Thu, 19 Apr 2018 12:33:06 +0300
Subject: [PATCH 0/6] arm64: untag user pointers passed to the kernel
In-Reply-To: <cover.1524077494.git.andreyknvl@google.com>
References: <cover.1524077494.git.andreyknvl@google.com>
Message-ID: <20180419093306.rn5bz264nxsn7d7c@node.shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2018 at 08:53:09PM +0200, Andrey Konovalov wrote:
> Hi!
> 
> arm64 has a feature called Top Byte Ignore, which allows to embed pointer
> tags into the top byte of each pointer. Userspace programs (such as
> HWASan, a memory debugging tool [1]) might use this feature and pass
> tagged user pointers to the kernel through syscalls or other interfaces.
> 
> This patch makes a few of the kernel interfaces accept tagged user
> pointers. The kernel is already able to handle user faults with tagged
> pointers and has the untagged_addr macro, which this patchset reuses.
> 
> We're not trying to cover all possible ways the kernel accepts user
> pointers in one patchset, so this one should be considered as a start.

How many changes do you anticipate?

This patchset looks small and reasonable, but I see a potential to become a
boilerplate. Would we need to change every driver which implements ioctl()
to strip these bits?

-- 
 Kirill A. Shutemov
