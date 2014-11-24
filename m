From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 24 Nov 2014 18:36:57 +0100
Subject: [PATCH] ARM: PJ4: allow building in Thumb-2 mode
In-Reply-To: <4653047.WBmUTsHC57@wuerfel>
References: <1416830200-11114-1-git-send-email-ard.biesheuvel@linaro.org>
 <2078609.NLHB18YoOo@wuerfel>
 <CAKv+Gu_YuHbO7+jusczcJTHF8fM4pF1z2h55BZK0mrHK702z_A@mail.gmail.com>
 <4653047.WBmUTsHC57@wuerfel>
Message-ID: <54736CB9.1090307@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 24/11/2014 18:17, Arnd Bergmann wrote:
> On Monday 24 November 2014 16:34:47 Ard Biesheuvel wrote:
>> On 24 November 2014 at 16:29, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Monday 24 November 2014 12:56:40 Ard Biesheuvel wrote:
>>>> Two files that get included when building the multi_v7_defconfig target
>>>> fail to build when selecting THUMB2_KERNEL for this configuration.
>>>>
>>>> In both cases, we can just build the file as ARM code, as none of its
>>>> symbols are exported to modules, so there are no interworking concerns.
>>>> In the iwmmxt.S case, add ENDPROC() declarations so the symbols are
>>>> annotated as functions, resulting in the linker to emit the appropriate
>>>> mode switches.
>>>>
>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>
>>> Ah, very nice. I tried this before, but my version didn't actually
>>> work, presumably because I didn't know about the ENDPROC() stuff.
>>>
>>> Have you tested this on a machine that has IWMMXT enabled?
>>>
>>
>> No, I don't have access to such a machine, unfortunately.
> 
> Adding a few mvebu folks to Cc, maybe one of them can test your patch.

Actually even it is a feature of the PJ4 machine non of the mvebu machines
currently use it. I only see this configuration enabled for the pxa family.
So I think you would have more feedback with the pxa maintainers/owners.

Gregory

> It's also possible that Olof or Kevin have a PJ4 machine with iwmmxt 
> in their boot farms.
> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
