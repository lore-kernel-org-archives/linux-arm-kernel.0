From: david@lechnology.com (David Lechner)
Date: Thu, 4 Jan 2018 11:43:12 -0600
Subject: [PATCH v4 2/7] ARM: davinci: don't use static clk_lookup
In-Reply-To: <17d6af61-a6db-9dc6-6fde-e9ff44e57389@ti.com>
References: <1514763588-31560-1-git-send-email-david@lechnology.com>
 <1514763588-31560-3-git-send-email-david@lechnology.com>
 <17d6af61-a6db-9dc6-6fde-e9ff44e57389@ti.com>
Message-ID: <dd1b775e-4c76-7f9c-00f1-dd1464919ae0@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/4/18 5:10 AM, Sekhar Nori wrote:
> Hi David,
> 
> On Monday 01 January 2018 05:09 AM, David Lechner wrote:
>> In preparation of moving to the common clock framework, usage of static
>> struct clk_lookup is removed. The common clock framework uses an opaque
>> struct clk, so we won't be able to use static tables as was previously
>> done.
>>
>> davinci_clk_init() is changed to init a single clock instead of a table
>> and an individual clk_register_clkdev() is added for each clock.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
> 
> Is there a need for this considering in 6/7 you end up modifying quite a
> bit of this patch again?

No, you are right. And I've been working ahead with device tree support 
so I think I want to do this a bit differently anyway.
