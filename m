From: gerg@snapgear.com (Greg Ungerer)
Date: Fri, 02 Oct 2009 10:28:45 +1000
Subject: [PATCH] arm: fix valid_phys_addr_range() range check
In-Reply-To: <20091001150424.GB28044@n2100.arm.linux.org.uk>
References: <200909240624.n8O6O4MO002196@localhost.localdomain>
	<20091001150424.GB28044@n2100.arm.linux.org.uk>
Message-ID: <4AC5493D.6000006@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Russell King - ARM Linux wrote:
> On Thu, Sep 24, 2009 at 04:24:04PM +1000, Greg Ungerer wrote:
>> arm: fix valid_phys_addr_range() range check
>>
>> Commit 1522ac3ec95ff0230e7aa516f86b674fdf72866c
>> ("Fix virtual to physical translation macro corner cases")
>> breaks the end of memory check in valid_phys_addr_range().
>> The modified expression results in the apparent /dev/mem size
>> being 2 bytes smaller than what it actually is.
>>
>> This patch reworks the expression to correctly check the address,
>> while maintaining use of a valid address to __pa().
> 
> Looks good, can you please send it to the patch system?

Done, patch 5740/1.

Thanks
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg at snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
