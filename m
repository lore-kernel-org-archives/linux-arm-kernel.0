From: fweimer@redhat.com (Florian Weimer)
Date: Wed, 7 Dec 2016 14:23:55 +0100
Subject: [Question] New mmap64 syscall?
In-Reply-To: <20161206185440.GA4654@yury-N73SV>
References: <20161206185440.GA4654@yury-N73SV>
Message-ID: <f544bcc3-8aae-1bd0-b744-9964fc038a51@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/2016 07:54 PM, Yury Norov wrote:
> 3. Introduce new mmap64() syscall like this:
> sys_mmap64(void *addr, size_t len, int prot, int flags, int fd, struct off_pair *off);
> (The pointer here because otherwise we have 7 args, if simply pass off_hi and
> off_lo in registers.)

I would prefer a batched mmap/munmap/mremap/mprotect/madvise interface, 
so that VM changes can be coalesced and the output reduced.  This 
interface could then be used to implement mmap on 32-bit architectures 
as well because the offset restrictions would not apply there.

Thanks,
Florian
