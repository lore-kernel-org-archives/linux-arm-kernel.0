From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 11 Mar 2014 11:07:22 +0000
Subject: [PATCH 1/2] clk: shmobile: clk-mstp: change to using clock-indices
In-Reply-To: <20140311051605.GB3649@verge.net.au>
References: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
 <1394196400-17112-2-git-send-email-ben.dooks@codethink.co.uk>
 <20140311051605.GB3649@verge.net.au>
Message-ID: <531EEE6A.3080802@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/14 05:16, Simon Horman wrote:
> On Fri, Mar 07, 2014 at 12:46:39PM +0000, Ben Dooks wrote:
>> With the addition of clock-indices, we need to change the renesas
>> clock implementation to use these instead of the local definition.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 2 +-
>>   drivers/clk/shmobile/clk-mstp.c                                     | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
>> index 5992dce..02a25d9 100644
>> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
>> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
>> @@ -43,7 +43,7 @@ Example
>>   		clock-output-names =
>>   			"tpu0", "mmcif1", "sdhi3", "sdhi2",
>>   			 "sdhi1", "sdhi0", "mmcif0";
>> -		renesas,clock-indices = <
>> +		clock-indices = <
>>   			R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
>>   			R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
>>   			R8A7790_CLK_MMCIF0
>> diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
>> index 42d5912..95a2aa7 100644
>> --- a/drivers/clk/shmobile/clk-mstp.c
>> +++ b/drivers/clk/shmobile/clk-mstp.c
>> @@ -197,7 +197,7 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
>>   			continue;
>>
>>   		parent_name = of_clk_get_parent_name(np, i);
>> -		ret = of_property_read_u32_index(np, "renesas,clock-indices", i,
>> +		ret = of_property_read_u32_index(np, "clock-indices", i,
>>   						 &clkidx);
>>   		if (parent_name == NULL || ret < 0)
>>   			break;
>
> Won't this break compatibility with existing DTBs?

That was the point of patch 2.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
