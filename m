From: fweimer@redhat.com (Florian Weimer)
Date: Fri, 3 Aug 2018 09:53:49 +0200
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
Message-ID: <9acdacdb-3bd5-b71a-3003-e48132ee1371@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2018 09:11 AM, Andrew Pinski wrote:
> Yes fix Links not to use memcpy on the framebuffer.
> It is undefined behavior to use device memory with memcpy.

Some (de facto) ABIs require that it is supported, though.  For example, 
the POWER string functions avoid unaligned loads and stores for this 
reason because the platform has the same issue with device memory.  And 
yes, GCC will expand memcpy on POWER to something that is incompatible 
with device memory. 8-(

If we don't want people to use memcpy, we probably need to provide a 
credible alternative.

Thanks,
Florian
