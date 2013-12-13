From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 12 Dec 2013 20:24:15 -0500
Subject: [PATCH v3 13/23] mm/lib/swiotlb: Use memblock apis for early
 memory allocations
In-Reply-To: <20131212170857.e36d016a95992c932da824b0@linux-foundation.org>
References: <1386625856-12942-1-git-send-email-santosh.shilimkar@ti.com>
 <1386625856-12942-14-git-send-email-santosh.shilimkar@ti.com>
 <20131212170857.e36d016a95992c932da824b0@linux-foundation.org>
Message-ID: <52AA61BF.9080204@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 December 2013 08:08 PM, Andrew Morton wrote:
> On Mon, 9 Dec 2013 16:50:46 -0500 Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> 
>> Switch to memblock interfaces for early memory allocator instead of
>> bootmem allocator. No functional change in beahvior than what it is
>> in current code from bootmem users points of view.
>>
>> Archs already converted to NO_BOOTMEM now directly use memblock
>> interfaces instead of bootmem wrappers build on top of memblock. And the
>> archs which still uses bootmem, these new apis just fallback to exiting
>> bootmem APIs.
> 
> This one makes my x86_64 test box fail to boot.  There's no obvious
> indication why and I don't have netconsole on this machine, sorry.  It
> simply fails to mount the root fs.
> 
> config:
> 
Thanks for config and reporting the issue.
Unfortunately I don't have ability to test x86 machine but will
try to analyze it and find out whats could be going wrong.

Failure around rootfs mount means it could be something to do
with memory free related code from the patch.

Regards,
Santosh
