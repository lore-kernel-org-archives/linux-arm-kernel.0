From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 07 Jun 2013 13:59:43 +0200
Subject: [PATCH 6/6] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
In-Reply-To: <000c01ce6360$237a7040$6a6f50c0$@samsung.com>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
 <20130408165626.GA30824@obsidianresearch.com>
 <000c01ce6360$237a7040$6a6f50c0$@samsung.com>
Message-ID: <1880458.2ksb8qtzHh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013 18:19:40 Jingoo Han wrote:
> Hi Jason Gunthorpe,
> 
> I implemented 'Single domain' with Exynos PCIe for last two months;
> however, it cannot work properly due to the hardware restriction.
> Each MEM region is hard-wired.
> 
> Thus, I will send Exynos PCIe V3 patch as 'Separate domains'.

Yes, I think that is best, if the hardware is clearly designed as
separate domains, this is what we should do by default in the
driver. For the Marvell case with its 10 separate ports, much
more address space would be wasted by having one domain per
port and that hardware let us work around it by remapping the
physical address space windows. For Exynos there is much less to
lose and I too cannot see how it would be done in the first
place.

	Arnd
