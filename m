From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Feb 2018 15:57:29 -0800
Subject: [PATCH] arm64: Make L1_CACHE_SHIFT configurable
In-Reply-To: <ca6c47f9-86df-bcdb-bbe1-eac9db68ec33@codeaurora.org>
References: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
 <ca6c47f9-86df-bcdb-bbe1-eac9db68ec33@codeaurora.org>
Message-ID: <ffc090d5-62c9-e608-32e2-8d13d01234e6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2018 03:52 PM, Timur Tabi wrote:
> On 02/12/2018 05:45 PM, Florian Fainelli wrote:
>> +config ARM64_L1_CACHE_SHIFT
>> +??? int
>> +??? default 7 if ARM64_L1_CACHE_SHIFT_7
>> +??? default 6
> 
> Shouldn't this be the other way around?? Everyone is used to 7 now, so
> you're changing the default back to 6.? I would think that it should be
> 7 by default, and platforms like Brahma-B53 should force it to 6.

That is debatable, is there a good publicly available table of what the
typical L1 cache line size is on ARMv8 platforms?
-- 
Florian
