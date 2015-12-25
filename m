From: pingbo.wen@linaro.org (Pingbo Wen)
Date: Fri, 25 Dec 2015 20:24:59 +0800
Subject: 16KB PAGE_SIZE not work on DB410C
In-Reply-To: <CAKv+Gu9mUVn80Vqr5NT7jjkSGd6BY_0cB6gVJ8VakHHWeWxM2A@mail.gmail.com>
References: <5677795C.2060409@linaro.org>
 <CAKv+Gu9mUVn80Vqr5NT7jjkSGd6BY_0cB6gVJ8VakHHWeWxM2A@mail.gmail.com>
Message-ID: <6DB39B31-8902-4A03-A66B-DC75E90A1C1C@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard

> ? 2015?12?21??15:06?Ard Biesheuvel <ard.biesheuvel@linaro.org> ???
> 
> On 21 December 2015 at 05:00, Pingbo Wen <pingbo.wen@linaro.org> wrote:
>> Hello,
>> 
>> I want to do some tests over 16KB page size on dragonboard 410c. And I merged
>> arm64-upstream branch over
>> 
>>  https://git.linaro.org/landing-teams/working/qualcomm/kernel.git integration-linux-qcomlt
>> 
>> which is based on Linux Kernel 4.3.
>> 
>> The db410c can boot into ubuntu in 4KB / 64KB page size, but when I set 16K page size, with
>> 47bit VA, the kernel hang before kernel_start(), no log output.
>> 
>> Does db410c support 16K page size? What can I do to boot it up?
>> 
> 
> Cortex-A5x does not support 16 KB page size

Is there any documents I can reference? As I have get from ARM document, the Cortex-A53 support 16k page size, and Cortex-A57 don?t. The document can be found at:

	http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0024a/BABDJHAD.html

Reference it here:

The supported granule sizes are 4KB, 16KB, and 64KB, and it is implementation defined which of the three are supported. Code that creates page tables is able to read the system register ID_AA64MMFR0_EL1, to find out which are the supported sizes. The Cortex-A53 processor supports all three sizes, but this is not the case for early versions of some processors, such as the Cortex-A57, which did not support the 16K granule size. The size is configurable for each translation table within the Translation Control Register (TCR_EL1).

Did I miss something?

Pingbo
