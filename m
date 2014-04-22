From: bjorn@kryo.se (Bjorn Andersson)
Date: Tue, 22 Apr 2014 08:35:02 -0700
Subject: [PATCH 0/3] pinctrl: qcom: Add IPQ8064 pinctrl support
In-Reply-To: <CACRpkdZ_TgS2XFHyEhkWTHsgdv-Yw2jj9342nDihiJjjGPh7Bw@mail.gmail.com>
References: <1397531437-9104-1-git-send-email-agross@codeaurora.org>
 <CACRpkdZ_TgS2XFHyEhkWTHsgdv-Yw2jj9342nDihiJjjGPh7Bw@mail.gmail.com>
Message-ID: <CAJAp7Ojhmz4tNyrPNCB7QYM=pXKOq+cqo0x_ozCAJfUA6FU9cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 8:11 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Apr 15, 2014 at 5:10 AM, Andy Gross <agross@codeaurora.org> wrote:
>
>> This set of patches adds pinctrl support for the Qualcomm IPQ8064 platform.
>> The IPQ8064 uses the same TLMM block as the APQ8064, but has a different number
>> of pins, functions, and function assignments.  The second patch contains the
>> devicetree documentation.  The last patch selects PINCTRL for all ARCH_QCOM
>> platforms.  This allows for selection of pinctrl support via a make menuconfig.
>>
>> Andy Gross (3):
>>   pinctrl: qcom: Add definitions for IPQ8064
>>   dt: Document Qualcomm IPQ8064 pinctrl binding
>>   ARM: qcom: Select PINCTRL by default for ARCH_QCOM
>
> Bj?rn can you look at this series?

I don't have access to documentation for this platform, but I think
the "code" looks sane.

I would however like to push for the sort order of the Makefile and
Kconfig to be corrected (IPQ should come after APQ). Maybe you could
do that while picking the patches up?

With that change I find this

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

>
> David/Bryan: can either of you ACK the changes hitting
> arch/arm/mach-qcom/Kconfig
> so I can merge this through the pinctrl tree?

Maintainer for qcom-soc is Kumar, I added him to the To list.
May I suggest that Kumar picks the last change in the series (addition
of PINCTRL), as it is unrelated to the rest of the series?

>
> Yours,
> Linus Walleij

Regards,
Bjorn
