From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Sat, 26 Dec 2015 11:52:03 +0000
Subject: 16KB PAGE_SIZE not work on DB410C
In-Reply-To: <6DB39B31-8902-4A03-A66B-DC75E90A1C1C@linaro.org>
References: <5677795C.2060409@linaro.org>
 <CAKv+Gu9mUVn80Vqr5NT7jjkSGd6BY_0cB6gVJ8VakHHWeWxM2A@mail.gmail.com>
 <6DB39B31-8902-4A03-A66B-DC75E90A1C1C@linaro.org>
Message-ID: <567E7F63.80707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/12/15 12:24, Pingbo Wen wrote:
> Hi Ard

Pingbo

>> Cortex-A5x does not support 16 KB page size
>
> Is there any documents I can reference? As I have get from ARM document, the Cortex-A53 support 16k page size, and Cortex-A57 don?t. The document can be found at:
>
> 	http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0024a/BABDJHAD.html
>
> Reference it here:
>
> The supported granule sizes are 4KB, 16KB, and 64KB, and it is implementation defined which of the three are supported. Code that creates page tables is able to read the system register ID_AA64MMFR0_EL1, to find out which are the supported sizes. The Cortex-A53 processor supports all three sizes, but this is not the case for early versions of some processors, such as the Cortex-A57, which did not support the 16K granule size. The size is configurable for each translation table within the Translation Control Register (TCR_EL1).
>


As it clearly says, it really depends on the implementation and by default A53 doesn't enable 16K support. If you have a debugger
could you check the $PC on the booting core and map it to the vmlinux symbol ? Please be aware that the address could be PA.
If the 16K is not supported the $PC will be in PA(__no_granule_support).

Cheers
Suzuki
