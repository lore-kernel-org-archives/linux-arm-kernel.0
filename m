From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Oct 2013 11:08:43 -0600
Subject: [PATCH V3] clk: palmas: add clock driver for palmas
In-Reply-To: <52542F69.30407@ti.com>
References: <1381238480-18852-1-git-send-email-ldewangan@nvidia.com>
 <525408B3.1000107@ti.com> <5254193A.70104@nvidia.com> <52542F69.30407@ti.com>
Message-ID: <52543C1B.3000403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2013 10:14 AM, Nishanth Menon wrote:
> On 10/08/2013 09:39 AM, Laxman Dewangan wrote:
>> Thanks Nishanth for review.
>>
>> On Tuesday 08 October 2013 06:59 PM, Nishanth Menon wrote:
>>> On 10/08/2013 08:21 AM, Laxman Dewangan wrote:
>>>> Palmas devices has two clock output CLK32K_KG and CLK32K_KG_AUDIO
>>> not all palmas devices have 2 clocks - example: tps659038
>>
>> This is for generic palmas and I have seen it for TPS65913, TPS65914, 
>> TPS80036. If the generic one is not compatible then it need to add  
>> device specific and at that time, it is require to update the binding 
>> document accordingly.
> 
> ?? you do have two clocks inside the device they should be represented
> as two compatible entities - that simplifies everyone's life.

I think the terminology you're using here is quite confusing.

Are you talking about having two different compatible values for two
different HW designs, where those different designs implement different
sets of clocks (which makes sense), or two different DT nodes for two
different clocks (which IMHO doesn't always, unless those different
clocks *truly* are separate IP blocks with completely independent
register regions, and where those IP blocks are likely to be re-used
as-is in other chips).
