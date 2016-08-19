From: panand@redhat.com (Pratyush Anand)
Date: Fri, 19 Aug 2016 20:49:13 +0530
Subject: [PATCH] fixup! arm64: kdump: add kdump support
In-Reply-To: <57B70AF8.1000603@arm.com>
References: <57B2E759.201@arm.com>
 <1471448011-20386-1-git-send-email-james.morse@arm.com>
 <20160819080020.GA584@localhost.localdomain>
 <57B70AF8.1000603@arm.com>
Message-ID: <20160819151913.GC22221@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/08/2016:02:34:48 PM, James Morse wrote:
> On 19/08/16 09:00, Pratyush Anand wrote:
> > On 17/08/2016:04:33:31 PM, James Morse wrote:
> >> copy_oldmem_page() and mmap_vmcore() provide two ways for userspace to read
> >> from /proc/vmcore. Neither of these check with memblock to see if the page
> >> they are accessing is nomap. On Seattle this causes:
> > 
> > Thanks for the patch.It did resolve the kernel crash issue with makedumpfile,
> > however neither there was any data in vmcore-dmesg nor crash utility was able to
> > work the saved vmcore.
> 
> vmcore-dmesg doesn't work for me, but crash did once I'd rebuilt it from the
> most recent source.

Yes, saved vmcore  worked with latest crash. However, we will need to correct
phys_offset and page_offset in kexec-tools to get meaningful output from vmcore-dmesg.

~Pratyush
> 
> The most recent commit I have is:
> b349598bb755 ("Fix for the ARM64 "bt -R <symbol>" option if the only reference")
> 
> Are you using an older version?
> 
> 
> Thanks,
> 
> James
> 
> 
> [0] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/447597.html
