From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 7 Jun 2013 12:32:29 +0000 (UTC)
Subject: [PATCH V2 14/14] ARM: OMAP4: hwmod data: Clean up the data
 file
In-Reply-To: <1370606175-22599-1-git-send-email-r.sricharan@ti.com>
References: <1370606175-22599-1-git-send-email-r.sricharan@ti.com>
Message-ID: <alpine.DEB.2.02.1306071230500.5589@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Sricharan R wrote:

> - The IO resource information like dma request lines, irq number and
>   ocp address space can be populated via dt blob. So such data is stripped
>   from OMAP4 SOC hwmod data file.
> 
> - The devices which are still missing the device tree bindings,
>   address space entries are not removed yet. When such devices add
>   the dt bindings, respective address space data can be deleted.
> 
> - Also other unnecessary hwmods like firewalls are removed as a part of this.
>   Since emif was getting registered only because of this firewalls links,
>   the mpu->emif direct link is added now.
> 
> The above update, results in reduction of about ~1650 lines of code.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

Can't test this one since I don't have an OMAP4 DT config set up in the testbed
yet.  Maybe will add that to the testbed after the v3.10 release.


- Paul
