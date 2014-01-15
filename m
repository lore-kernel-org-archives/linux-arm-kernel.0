From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 15 Jan 2014 18:03:01 +0100
Subject: [RFC PATCH 3/9] of: mtd: add NAND timings retrieval support
In-Reply-To: <52D6A48D.4080302@overkiz.com>
References: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>
 <1389190924-26226-4-git-send-email-b.brezillon@overkiz.com>
 <20140108183418.GA12358@obsidianresearch.com> <52CDA032.3010804@overkiz.com>
 <20140108191339.GB12358@obsidianresearch.com> <52CE5F82.6070802@overkiz.com>
 <20140109173505.GB8899@obsidianresearch.com> <52D6A48D.4080302@overkiz.com>
Message-ID: <52D6BF45.80407@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/2014 16:09, boris brezillon wrote:
> Hello Jason,
>
> On 09/01/2014 18:35, Jason Gunthorpe wrote:
>> On Thu, Jan 09, 2014 at 09:36:18AM +0100, boris brezillon wrote:
>>
>>>> You might want to check if you can boil down the DT timings from the
>>>> huge list to just an ONFI mode number..
>>> Sure, but the sunxi driver needs at least 19 of them...
>> So does mvebu's NAND driver..
>>
>> What I ment was you could have a
>>
>>    onfi,nand-timing-mode = 0
>>
>> in the DT. Each of the modes defines all ~19 parameters, higher modes
>> are faster.
>>
>> Pick a mode value that fits all the parameters of the connected
>> non-ONFI flash.
>>
>> This would be instead of defining each parameter
>> individually.. Provide some helpers to convert from a onfi mode number
>> to all the onfi defined timing parameters so that drivers can
>> configure the HW..
>
> Are you suggesting we should provide a function that converts these
> modes into a nand_timings struct, or just use the timing modes and
> let the NAND controller drivers configure its IP accordingly ?
>
> I found the ONFI timing tables in this document:
>
> www.*onfi*.org/~/media/*ONFI*/specs/*onfi*_3_1_spec.pdf? (chapter 4.16).
>
> I suppose my nand_timings struct should use the names described
> page 110-111 (at least if we decide to use nand_timings and not
> nand_timing_modes), right ?

After taking a closer look at this document, the only parameter 
available in my
nand_timings struct that is not defined in the standard is tR_max (data 
transfer
from cell to register).

And the ONFI standard defines 4 more timings:
- tCEA_max
- tCEH_min
- tFEAT_max
- tITC_max



>
> Best Regards,
>
> Boris
>
>>
>> Jason
>
