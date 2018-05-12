From: david@lechnology.com (David Lechner)
Date: Sat, 12 May 2018 16:11:06 -0500
Subject: =?UTF-8?Q?Re:_[PATCH_v10_00/27]_ARM:_davinci:_convert_to_common_clo?=
 =?UTF-8?B?Y2sgZnJhbWV3b3Jr4oCL?=
In-Reply-To: <45ce3129-4a9e-54d2-e594-49b451571842@ti.com>
References: <20180509172606.29387-1-david@lechnology.com>
 <45ce3129-4a9e-54d2-e594-49b451571842@ti.com>
Message-ID: <0b62ac7b-aa02-6641-2a02-6cefb4076262@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2018 10:26 AM, Sekhar Nori wrote:
> Hi David,
> 
> On Wednesday 09 May 2018 10:55 PM, David Lechner wrote:
>> This series converts mach-davinci to use the common clock framework.
>>
>> The series works like this, the first 3 patches fix some issues with the clock
>> drivers that have already been accepted into the mainline kernel.
> 
> I have not yet looked at the patches, but I got a bunch of W=1 warnings
> and some sparse warnings when building your branch. Please take a look
> at these. Unfortunately the output is mixed between sparse and compiler.
> The "expression using sizeof(void)" can be ignored as its a known issue
> with sparse, I believe.
> 

I've started a common-clk-v11 branch on my GitHub that fixes most of these.
Also submitted "clk: davinci: psc-dm355: fix ASP0/1 clkdev lookups" that
fixes a couple more. I've purposely not fixed the davinci_clk_reset_* functions
since there is already a patch that will remove those functions in the future.

I'll wait a bit longer for DT review before re-sending v11 of this series.
