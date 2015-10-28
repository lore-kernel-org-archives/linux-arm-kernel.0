From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 28 Oct 2015 11:11:33 +0900
Subject: [PATCH] arm64: efi: make sure vmlinux load address aligned on
 2MBytes
In-Reply-To: <56302E7C.7000605@codeaurora.org>
References: <1445981041-8774-1-git-send-email-timur@codeaurora.org>
 <CAKv+Gu_ivkemFva-Fu0E24mQqE-m0jPWBzo5OZAr7cyM08hqug@mail.gmail.com>
 <56302E7C.7000605@codeaurora.org>
Message-ID: <CAKv+Gu9t=dGoaVem+h11cXfimpEzmte36_j4tKW_h8rA8c1jBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 October 2015 at 11:10, Timur Tabi <timur@codeaurora.org> wrote:
> Ard Biesheuvel wrote:
>>
>> +               *image_addr = *reserve_addr = round_up(dram_base, SZ_2M) +
>> +                                                      TEXT_OFFSET);
>
>
> Shouldn't this be:
>
> *image_addr = *reserve_addr = round_up(dram_base + TEXT_OFFSET, SZ_2M);
>

No. I screwed up the patch since the trailing ) should not be there,
but we do need to round first, and only then add the offset.

-- 
Ard.
