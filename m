From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Mon, 24 Aug 2015 19:18:33 +0300
Subject: [PATCH v2 5/5] arm64: add KASan support
In-Reply-To: <55DB4372.5010406@arm.com>
References: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
 <1431698344-28054-6-git-send-email-a.ryabinin@samsung.com>
 <CACRpkdaRJJjCXR=vK1M2YhR26JZfGoBB+jcqz8r2MhERfxRzqA@mail.gmail.com>
 <CAPAsAGy-r8Z2N09wKV+e0kLfbwxd-eWK6N5Xajsnqq9jfyWqcQ@mail.gmail.com>
 <CACRpkdZmHLMxosLXjyOPdkavo=UNzmTcHOLF5vV4cS1ULfbq6A@mail.gmail.com>
 <CAPAsAGw-iawTpjJh66rQN5fqBFT6UBZCcv2eKx7JTqCXzhzpsw@mail.gmail.com>
 <CACRpkdY2i2M27gP_fXawkFrC_GFgWaKr5rEn6d47refNPiEk=g@mail.gmail.com>
 <55AE56DB.4040607@samsung.com>
 <CACRpkdYaqK8upK-3b01JbO_y+sHnk4-Hm1MfvjSy0tKUkFREtQ@mail.gmail.com>
 <20150824131557.GB7557@n2100.arm.linux.org.uk>
 <CACRpkdYwpucRiXM05y00RQY=gKv8W6YjCNspYFRMGaM605cU0w@mail.gmail.com>
 <CAPAsAGwji7FpUJK9O=FWYN15-rJkYMQyOt9W9ncdY9uLybxkiA@mail.gmail.com>
 <55DB3BD3.7030202@arm.com>
 <CAPAsAGyg_oUvUrfSSQccVMcGtY_bwR8n6tf3tFsnh43YT6-b4w@mail.gmail.com>
 <55DB4372.5010406@arm.com>
Message-ID: <CAPAsAGwwEpKVVk4bxKhrGSQ-YBi74CrjTsn8Xmy4YpRB8c84VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-08-24 19:16 GMT+03:00 Vladimir Murzin <vladimir.murzin@arm.com>:
> On 24/08/15 17:00, Andrey Ryabinin wrote:
>> 2015-08-24 18:44 GMT+03:00 Vladimir Murzin <vladimir.murzin@arm.com>:
>>>
>>> Another option would be having "sparse" shadow memory based on page
>>> extension. I did play with that some time ago based on ideas from
>>> original v1 KASan support for x86/arm - it is how 614be38 "irqchip:
>>> gic-v3: Fix out of bounds access to cpu_logical_map" was caught.
>>> It doesn't require any VA reservations, only some contiguous memory for
>>> the page_ext itself, which serves as indirection level for the 0-order
>>> shadow pages.
>>
>> We won't be able to use inline instrumentation (I could live with that),
>> and most importantly, we won't be able to use stack instrumentation.
>> GCC needs to know shadow address for inline and/or stack instrumentation
>> to generate correct code.
>
> It's definitely a trade-off ;)
>
> Just for my understanding does that stack instrumentation is controlled
> via -asan-stack?
>

Yup.
