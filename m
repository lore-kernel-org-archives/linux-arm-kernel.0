From: yang.shi@linaro.org (Shi, Yang)
Date: Tue, 10 Nov 2015 16:26:02 -0800
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <1447200535.17135.88.camel@edumazet-glaptop2.roam.corp.google.com>
References: <1447195301-16757-1-git-send-email-yang.shi@linaro.org>	
 <1447195301-16757-3-git-send-email-yang.shi@linaro.org>
 <1447200535.17135.88.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <56428B1A.5090303@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2015 4:08 PM, Eric Dumazet wrote:
> On Tue, 2015-11-10 at 14:41 -0800, Yang Shi wrote:
>> aarch64 doesn't have native support for XADD instruction, implement it by
>> the below instruction sequence:
>>
>> Load (dst + off) to a register
>> Add src to it
>> Store it back to (dst + off)
>
> Not really what is needed ?
>
> See this BPF_XADD as an atomic_add() equivalent.

I see. Thanks. The documentation doesn't say too much about "exclusive" 
add. If so it should need load-acquire/store-release.

I will rework it.

Yang

>
>
