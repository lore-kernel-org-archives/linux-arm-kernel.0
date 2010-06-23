From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 24 Jun 2010 00:15:11 +0530
Subject: Unhandled fault: imprecise external abort
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5D15BE2@dbde02.ent.ti.com>
References: <AANLkTimFhC7PZaT9VVwyVH-jp7Ro74w7sSX2Ma1SX7Mn@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5D15BE2@dbde02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5D15BE3@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> _______________________________________
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Pankaj Pandey
> Sent: Wednesday, June 23, 2010 9:30 PM
> To: linux-arm-kernel at lists.infradead.org
> Subject: Unhandled fault: imprecise external abort
> 
> Hi,
> 
> I am working on Freescale MXC series based target board runing? with 2.6.31 kernel. I have written a
> small test application to test the one of? driver. In my test application, I am using mmap to map the
> kernel memory to user space and? I am trying to read some register values.
> My user space mmap function is as such :
> 
> ?virt_addr = mmap(NULL, 4 * 1024, PROT_READ, MAP_SHARED ,fd, 0);
> 
> The mmap returns a specific address in virt_addr.
> 
> When I try to read the contents of this address , the kernel throws following error :
> 
> ?Unhandled fault: imprecise external abort (0xc06) at 0x00000000
> 
> Any pointers on this will great help to resolve this issue.
> 
Are you able to access these registers from kernel space ??
If the kernel space access also reports the external abort then looks like you
are trying to access the registers of module which is not clocked 
or is in non-accessible state.

Regards,
Santosh
