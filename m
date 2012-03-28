From: snjw23@gmail.com (Sylwester Nawrocki)
Date: Wed, 28 Mar 2012 21:45:14 +0200
Subject: Handling device shared SFR on dt platform
In-Reply-To: <20120324193200.822AD3E0B06@localhost>
References: <4F6A5853.9090809@gmail.com> <20120324193200.822AD3E0B06@localhost>
Message-ID: <4F736A4A.6050302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Grant,

On 03/24/2012 08:32 PM, Grant Likely wrote:
>
> Generally, this is handled by having a third node for the shared
> register block and both device nodes holding a phandle to it.
> 
> No, there isn't any common infrastructure for implementing this, but
> it isn't very much code.

Thank you, that sounds good. I'm just wondering how to handle the shared
resource access synchronisation. There is an IORESOURCE_MUXED resource type 
flag which could be used to prevent drivers from stomping on each others 
feet when accessing the shared register, if I understand the software muxed
resource semantics correctly. That is, using something like 
request_muxed_(mem_)region()/release_mem_region() for the shared register
protection.

What concerns me, is an overhead from region request/ioremap(?)/release, just
to access a single 32-bit register. I'm going to see if those accesses could
be moved to only device driver's probe() and remove() callbacks and what might
be the resulting power consumption increase from that, if any.


--

Thanks,
Sylwester
