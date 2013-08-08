From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 8 Aug 2013 10:19:54 -0400
Subject: [PATCHv3 4/9] ARM: OMAP2+: AM33XX: Reserve memory to comply with
 EMIF spec
In-Reply-To: <1375811376-49985-5-git-send-email-d-gerlach@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-5-git-send-email-d-gerlach@ti.com>
Message-ID: <5203A90A.8090008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 August 2013 01:49 PM, Dave Gerlach wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
> 
> SDRAM controller on AM33XX requires that a modification of certain
> bit-fields in PWR_MGMT_CTRL register (ref. section 7.3.5.13 in
> AM335x-Rev H) is followed by a dummy read access to SDRAM. This
> scenario arises when entering a low power state like DeepSleep.
> To ensure that the read is not from a cached region we reserve
> some memory during bootup using the arm_memblock_steal() API.
> 
> A subsequent patch will pass along the location of the reserved
> memory location to the AM335x suspend handler which modifies the
> PWR_MGMT_CTRL register in the EMIF.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
