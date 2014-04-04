From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 04 Apr 2014 16:10:52 -0600
Subject: [PATCH 73/75] ARM: l2c: move L2 cache register saving to a more
 sensible location
In-Reply-To: <20140403185216.GS7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYaF-0007Hv-Nv@rmk-PC.arm.linux.org.uk> <533B0BC1.6080608@wwwdotorg.org>
 <533B0D6D.1080803@wwwdotorg.org>
 <20140401230924.GE7528@n2100.arm.linux.org.uk>
 <533C633C.9070100@wwwdotorg.org>
 <20140403185216.GS7528@n2100.arm.linux.org.uk>
Message-ID: <533F2DEC.7060608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2014 12:52 PM, Russell King - ARM Linux wrote:
> On Wed, Apr 02, 2014 at 01:21:32PM -0600, Stephen Warren wrote:
>> On 04/01/2014 05:09 PM, Russell King - ARM Linux wrote:
>>> On Tue, Apr 01, 2014 at 01:03:09PM -0600, Stephen Warren wrote:
>>>> On 04/01/2014 12:56 PM, Stephen Warren wrote:
>>>>> On 03/28/2014 09:20 AM, Russell King wrote:
...
>>>>> However, this one patch causes boot failures on the Toshiba AC100,
>>>>> Springbank/Seaboard, and I would assume any Tegra20 system. I haven't
>>>>> investigated what the problem is; do you need me to and/or have any clues?
...
>> Anyway, this patch removes the following code:
>> 
>> 	/* Save the value for resuming. */
>> 	l2x0_saved_regs.aux_ctrl = aux;
...
> This is my preferred solution (patch on top of this series.)  Will be
> merged into the series shortly.  Thanks for finding this.
> 
>  arch/arm/mm/cache-l2x0.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
...

Tested-by: Stephen Warren <swarren@nvidia.com>
