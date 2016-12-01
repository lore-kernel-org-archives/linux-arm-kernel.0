From: labbott@redhat.com (Laura Abbott)
Date: Thu, 1 Dec 2016 11:10:35 -0800
Subject: [PATCHv4 08/10] mm/kasan: Switch to using __pa_symbol and lm_alias
In-Reply-To: <2f3ac043-c4cc-5c5a-8ac7-1396b6bb193f@virtuozzo.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <1480445729-27130-9-git-send-email-labbott@redhat.com>
 <2f3ac043-c4cc-5c5a-8ac7-1396b6bb193f@virtuozzo.com>
Message-ID: <9dc192b3-a3bd-303a-1b65-00a735a38c74@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2016 03:36 AM, Andrey Ryabinin wrote:
> On 11/29/2016 09:55 PM, Laura Abbott wrote:
>> __pa_symbol is the correct API to find the physical address of symbols.
>> Switch to it to allow for debugging APIs to work correctly.
> 
> But __pa() is correct for symbols. I see how __pa_symbol() might be a little
> faster than __pa(), but there is nothing wrong in using __pa() on symbols.
> 
>> Other
>> functions such as p*d_populate may call __pa internally. Ensure that the
>> address passed is in the linear region by calling lm_alias.
> 
> Why it should be linear mapping address? __pa() translates kernel image address just fine.
> This lm_alias() only obfuscates source code. Generated code is probably worse too.
> 
> 

This is part of adding CONFIG_DEBUG_VIRTUAL for arm64. We want to
differentiate between __pa and __pa_symbol to enforce stronger
virtual checks and have __pa only be for linear map addresses.

Thanks,
Laura
