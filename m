From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 22 Sep 2009 15:04:07 +0530
Subject: Kernel related (?) user space crash at ARM11 MPCore
In-Reply-To: <1253610085.14049.22.camel@pc1117.cambridge.arm.com>
References: <4A7AEEB6.5060903@googlemail.com>
	<1250184014.14019.40.camel@pc1117.cambridge.arm.com>
	<1250501311.9858.24.camel@pc1117.cambridge.arm.com>
	<20090817140422.GA10764@n2100.arm.linux.org.uk>
	<1250529916.11185.80.camel@pc1117.cambridge.arm.com>
	<20090919224022.GA738@n2100.arm.linux.org.uk>
	<1253435940.498.15.camel@pc1117.cambridge.arm.com>
	<20090920093139.GA1704@n2100.arm.linux.org.uk>
	<4AB6A664.3010704@arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BABA388A@dbde02.ent.ti.com>
	<1253610085.14049.22.camel@pc1117.cambridge.arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BACC4AF6@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Tuesday, September 22, 2009 2:31 PM
> To: Shilimkar, Santosh
> Cc: Russell King - ARM Linux; Dirk Behme; linux-arm-
> kernel at lists.infradead.org
> Subject: RE: Kernel related (?) user space crash at ARM11 MPCore
> 
> On Tue, 2009-09-22 at 11:14 +0530, Shilimkar, Santosh wrote:
> > Even though this thread is mainly focused on SMP + WA cache, can you
> > point out some reference which support your argument that " the
> > non-SMP v6/v7 processors I'm aware of only support read-allocate
> > caches, even if you try to force write-allocate". Mainly Cortex-a8
> > (ARMv7). The Cortex-A8 TRM says that it does support WBWA cache.
> 
> Please note the "I'm aware of" part. This could be limited to what I
> have on my desk.
> 
> Regarding the Cortex-A8 - the 7.3.3 section in the latest TRM (Level 1
> Memory System -> Memory attributes -> Normal) has a table which says for
> the WBWA L1 configuration:
> 
>         This is not supported. L1 is always in the no write-allocate
>         mode.
> 
> The L2 (inner cache) supports the write-allocate mode but this is a
> unified cache and doesn't affect the problem we are seeing here.

Thanks Catalin for information!!

Regards,
Santosh
