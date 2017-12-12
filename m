From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 12 Dec 2017 18:02:55 +0000
Subject: [PATCH] ARM: verify size of zImage
In-Reply-To: <87mv2oq67r.fsf@free-electrons.com>
References: <E1eJiiq-0006k9-FE@rmk-PC.armlinux.org.uk>
 <CAKv+Gu-oXSpUcJ6acBKyohQ3WxSDp3sK7A4No2y4CHCFw1kSaQ@mail.gmail.com>
 <87mv2oq67r.fsf@free-electrons.com>
Message-ID: <CAKv+Gu9x-8kiQhfqFKFAdVnOzq_eX94H7xTn=cGyCVcL_d0H4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 December 2017 at 16:08, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Ard,
>
>  On mar., nov. 28 2017, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> (+ Gregory)
>>
>> On 28 November 2017 at 16:27, Russell King <rmk+kernel@armlinux.org.uk> wrote:
>>> The linker can sometimes add additional sections to the zImage ELF file
>>> which results in the zImage binary being larger than expected.  This
>>> causes appended DT blobs to fail.
>>>
>>> Verify that the zImage binary is the expected size, and fail the build
>>> if this is not the case.
>>>
>>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>>> ---
>>> As this patch is different, I've dropped Matthias' tested-by.  I'd
>>> appreciate a replacement, thanks.  Also, I seem to remember that
>>> Ard's toolchain was giving issues - maybe this alternative will
>>> finally resolve them.
>>>
>>
>> $ nm arch/arm/boot/compressed/vmlinux |grep _edata
>> 007b8200 D _edata
>> 007b8200 D _edata_real
>>
>> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> although I don't remember seeing this fail. It think it may have been
>> Gregory who was having these issues?
>
> Thanks to remember me, I finally find time to test it, and with my setup
> I didn't have anymore issue while building it for a dtb append zImage
> for Armada XP:
>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>

Thanks for confirming.
