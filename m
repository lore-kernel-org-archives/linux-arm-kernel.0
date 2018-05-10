From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 10 May 2018 11:07:09 +0100
Subject: [PATCH 3/3] arm64: dts: juno/rtsm: re-structure motherboard
 includes
In-Reply-To: <20180510094901.GR1027@e110455-lin.cambridge.arm.com>
References: <1525884291-18851-1-git-send-email-sudeep.holla@arm.com>
 <1525884291-18851-3-git-send-email-sudeep.holla@arm.com>
 <20180510094901.GR1027@e110455-lin.cambridge.arm.com>
Message-ID: <fd05b1da-83aa-2177-8e99-23dcb7199856@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/05/18 10:49, Liviu Dudau wrote:
> On Wed, May 09, 2018 at 05:44:51PM +0100, Sudeep Holla wrote:
>> It is a bit unorthodox to just include a file in the middle of a another
>> DTS file, it breaks the pattern from other device trees and also makes
>> it really hard to reference things across the files with phandles.
>>
>> Restructure the include for the Juno/RTSM motherboards to happen at the
>> top of the file, reference the target nodes directly, and indent the
>> motherboard .dtsi files to reflect their actual depth in the hierarchy.
>>
>> This is a purely syntactic change that result in the same DTB files from
>> the DTS/DTSI files. This is based on similar patch from Linus Walleij
>> for ARM Vexpress platforms.
> 
> A bit of bikeshedding here: the reason I've used the DT /include/
> here was that on decompilation of the DTB the nodes would have been in
> the natural order and easier to look for issues. Those were the early
> days and I can accept that the general practice has changed and we're
> using now the C preprocessor more. I don't have any strong feelings on
> how the DT looks nowadays, so:
>

I can understand. After this patch applied, I did hit an issue with
timer registration. I just posted a patch [1]

>>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
> 
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
> 

Thanks for all the acks.

-- 
Regards,
Sudeep

[1]
https://lkml.kernel.org/r/1525881728-4858-1-git-send-email-sudeep.holla at arm.com
