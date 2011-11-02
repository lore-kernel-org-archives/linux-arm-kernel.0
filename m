From: balbi@ti.com (Felipe Balbi)
Date: Wed, 2 Nov 2011 22:40:07 +0200
Subject: [PATCH] arm/tegra: add support for tegra30 interrupts
In-Reply-To: <20111102195404.GF12913@n2100.arm.linux.org.uk>
References: <1320248292-22736-1-git-send-email-pdeschrijver@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173F9A46E5@HQMAIL01.nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173F9A4758@HQMAIL01.nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173F9A47A7@HQMAIL01.nvidia.com>
	<20111102192112.GC12913@n2100.arm.linux.org.uk>
	<20111102192625.GD14372@legolas.emea.dhcp.ti.com>
	<20111102193947.GD12913@n2100.arm.linux.org.uk>
	<20111102194827.GF14372@legolas.emea.dhcp.ti.com>
	<20111102195404.GF12913@n2100.arm.linux.org.uk>
Message-ID: <20111102204006.GA14564@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 02, 2011 at 07:54:04PM +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 02, 2011 at 09:48:28PM +0200, Felipe Balbi wrote:
> > Hi,
> > 
> > you forgot to comment on the fact that gpio_desc shouldn't be held in an
> > array. Any comments ?
> 
> I did not comment on that because that's someone elses problem.

fair enough.

> > What I mean is that, just like irq_descs, we should be able to allocate
> > them dynamically. Maybe, just like irq_descs, hold them in a radix tree
> > and maybe even have a matching API "gpio_alloc_descs()".
> 
> Probably - I expect Grant would really like to see some patches along
> those lines.  As I say, someone elses problem.
> 
> But what is _our_ problem is what to do with all the ARCH_NR_GPIOs
> that we have now, and stop them increasing.  There is a trivial solution
> to that which I outlined which can be used until GPIO gets something
> along your idea - and which doesn't involve me having to argue with
> those who think that the kernel should remain as small as possible.

k, I'll see if I can cook something up.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111102/7efcc906/attachment.sig>
