From: zlim.lnx@gmail.com (Z Lim)
Date: Tue, 10 Nov 2015 18:52:45 -0800
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <20151111004208.GA47378@ast-mbp.thefacebook.com>
References: <1447195301-16757-1-git-send-email-yang.shi@linaro.org>
 <1447195301-16757-3-git-send-email-yang.shi@linaro.org>
 <1447200535.17135.88.camel@edumazet-glaptop2.roam.corp.google.com>
 <56428B1A.5090303@linaro.org>
 <20151111004208.GA47378@ast-mbp.thefacebook.com>
Message-ID: <CABg9mcux0wEC5=nWuR9o8NwUTp73zqZ-N2e67_f7oS_mX1XGdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yang,

On Tue, Nov 10, 2015 at 4:42 PM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Tue, Nov 10, 2015 at 04:26:02PM -0800, Shi, Yang wrote:
>> On 11/10/2015 4:08 PM, Eric Dumazet wrote:
>> >On Tue, 2015-11-10 at 14:41 -0800, Yang Shi wrote:
>> >>aarch64 doesn't have native support for XADD instruction, implement it by
>> >>the below instruction sequence:

aarch64 supports atomic add in ARMv8.1.
For ARMv8(.0), please consider using LDXR/STXR sequence.

>> >>
>> >>Load (dst + off) to a register
>> >>Add src to it
>> >>Store it back to (dst + off)
>> >
>> >Not really what is needed ?
>> >
>> >See this BPF_XADD as an atomic_add() equivalent.
>>
>> I see. Thanks. The documentation doesn't say too much about "exclusive" add.
>> If so it should need load-acquire/store-release.
>
> I think doc is clear enough, but it can always be improved. Pls suggest a patch.
> It's quite hard to write a test for atomicity in test_bpf framework, so
> code review is the key. Eric, thanks for catching it!
>
