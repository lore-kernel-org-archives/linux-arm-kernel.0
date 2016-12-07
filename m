From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 7 Dec 2016 21:18:11 +0530
Subject: [Question] New mmap64 syscall?
In-Reply-To: <f544bcc3-8aae-1bd0-b744-9964fc038a51@redhat.com>
References: <20161206185440.GA4654@yury-N73SV>
 <f544bcc3-8aae-1bd0-b744-9964fc038a51@redhat.com>
Message-ID: <20161207154811.GA15248@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 02:23:55PM +0100, Florian Weimer wrote:
> On 12/06/2016 07:54 PM, Yury Norov wrote:
> >3. Introduce new mmap64() syscall like this:
> >sys_mmap64(void *addr, size_t len, int prot, int flags, int fd, struct off_pair *off);
> >(The pointer here because otherwise we have 7 args, if simply pass off_hi and
> >off_lo in registers.)
> 
> I would prefer a batched mmap/munmap/mremap/mprotect/madvise interface, so
> that VM changes can be coalesced and the output reduced.  This interface
> could then be used to implement mmap on 32-bit architectures as well because
> the offset restrictions would not apply there.

Hi Florian,

I frankly don't understand what you mean, All syscalls you mentioned
doesn't take off_t or other 64-bit arguments. 'VM changes' - virtual
memory? If so, I don't see any changes in VM with this approach, just
correct handling of big offsets.

> This interface
> could then be used to implement mmap on 32-bit architectures as well 

This is for 32-bit architectures only. 64 bit arches use
sysdeps/unix/sysv/linux/wordsize-64/mmap.c for both mmap and mmap64,
and they don't need that tricks with off_t. Or you meaning to switch
64-bit mmap to this interface?

Please explain what you mean in details.

Yury
