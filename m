From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 30 Jun 2016 12:39:03 +0100
Subject: [Question] Memory attribute reserved by Device Tree?
In-Reply-To: <CAK7LNATGoP-Wn-wiK_CgD_v=rQXyt937qRvr8LkUQ06jHB7FAA@mail.gmail.com>
References: <CAK7LNATGoP-Wn-wiK_CgD_v=rQXyt937qRvr8LkUQ06jHB7FAA@mail.gmail.com>
Message-ID: <577504D7.7080106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/06/16 12:10, Masahiro Yamada wrote:
> Hello.
> 
> Which memory attribute will ARM/ARM64 Linux
> set to the memory region reserved by
> /memreserve/ of Device Tree?
> 
> 
> Normal memory non-cacheable?
> Or, cacheable?
> Or, not defined?
> 
> Perhaps actual behavior depends on whether the reserved area is
> located in the low-memory region?

Isn't the point of memreserve that the kernel avoids mapping it at all?
If a reserved region is later mapped in by a driver using
dma_declare_coherent_memory(), ioremap(), memremap() or whatever else,
then the attributes will vary depending on the exact method used.

Robin.

> 
> 
> Thanks,
> 
> 
