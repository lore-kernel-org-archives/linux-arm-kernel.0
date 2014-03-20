From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Mar 2014 13:04:05 -0600
Subject: [V2] arm: pj4: check cpu id for pj4 cp0 access
In-Reply-To: <20140318201537.GA20942@beef>
References: <1371200637-20850-1-git-send-email-chao.xie@marvell.com>
 <20140318201537.GA20942@beef>
Message-ID: <532B3BA5.7080209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2014 02:15 PM, Matt Porter wrote:
> On Fri, Jun 14, 2013 at 05:03:57AM -0400, Chao Xie wrote:
>> Check cpu id in pj4_cp0_init. So for no-PJ4 V7 cpus,
>> pj4_cpu0_init just return.
>> This fix will help to make the all the V7 cpus(pj4 and no-PJ4)
>> use same platform code.
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> This patch fixes a boot failure in next now that ARCH_DOVE (and thus
> CPU_PJ4) are enabled in multi_v7_defconfig. I verified that boot works
> again in next with the BCM28155-AP board.
> 
> Tested-by: Matt Porter <mporter@linaro.org>

This also solves the Tegra SoC boot failures with next-20130320.
Tested-by: Stephen Warren <swarren@nvidia.com>
