From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Thu, 2 Mar 2017 08:34:26 +0100
Subject: [PATCHv2 00/14] set_memory_* functions header refactor
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Message-ID: <20170302073426.GA7265@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 04:14:52PM -0800, Laura Abbott wrote:
> Hi,
> 
> This is v2 of my proposal to move set_memory_* function prototypes out of
> cacheflush.h and into their own header file. This came out of a comment
> Russell made while reviewing RODATA test cases
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/480855.html
> While the final result of that series was the rodata code was refactored into
> its own header file, the set_memory_* APIs are still out of place.
> 
> This version refactored the common set_memory_* functions into an asm-generic
> header. s390x added some features so it can't just use the asm-generic header.
> I debated how much more to try and shove into the asm-generic version (e.g.
> stub prototypes for the ARM nommu case, set_kernel_text_*) but decided to stick
> with just the basics for this version.
> 
> I split out the cacheflush.h -> set_memory.h conversions into separate patches
> to hopefully make merging easier. Worst case, the final patch to completely
> separate the two can be delayed if there are more problems found. I'd like
> for this to eventually go through the -mm tree so I'd like Acks where
> appropriate.
> 
> As always, feedback appreciated.

For the s390 bits:
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
