From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 25 Nov 2014 17:14:40 +0100
Subject: [PATCH] ARM: PJ4: allow building in Thumb-2 mode
In-Reply-To: <CAKv+Gu9sGGh-xHBNWNPLQd+Ndoms-7XfjjtSB649fe+R0Kz-_g@mail.gmail.com>
References: <1416830200-11114-1-git-send-email-ard.biesheuvel@linaro.org>	<2078609.NLHB18YoOo@wuerfel>	<CAKv+Gu_YuHbO7+jusczcJTHF8fM4pF1z2h55BZK0mrHK702z_A@mail.gmail.com>	<4653047.WBmUTsHC57@wuerfel>	<54736CB9.1090307@free-electrons.com>	<CAKv+Gu8tgySFMwWixX6Z84nq-Wci=DWdGhvxpmBHQ8fgQr-jmw@mail.gmail.com>	<54738097.4020208@free-electrons.com>
 <CAKv+Gu9sGGh-xHBNWNPLQd+Ndoms-7XfjjtSB649fe+R0Kz-_g@mail.gmail.com>
Message-ID: <5474AAF0.1040108@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/11/2014 20:49, Ard Biesheuvel wrote:
> On 24 November 2014 at 20:01, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> On 24/11/2014 18:48, Ard Biesheuvel wrote:
>>> On 24 November 2014 at 18:36, Gregory CLEMENT
>>> <gregory.clement@free-electrons.com> wrote:
>>>> Hi Arnd,
>>>>
>>>> On 24/11/2014 18:17, Arnd Bergmann wrote:
>>>>> On Monday 24 November 2014 16:34:47 Ard Biesheuvel wrote:
>>>>>> On 24 November 2014 at 16:29, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>>>> On Monday 24 November 2014 12:56:40 Ard Biesheuvel wrote:
>>>>>>>> Two files that get included when building the multi_v7_defconfig target
>>>>>>>> fail to build when selecting THUMB2_KERNEL for this configuration.
>>>>>>>>
>>>>>>>> In both cases, we can just build the file as ARM code, as none of its
>>>>>>>> symbols are exported to modules, so there are no interworking concerns.
>>>>>>>> In the iwmmxt.S case, add ENDPROC() declarations so the symbols are
>>>>>>>> annotated as functions, resulting in the linker to emit the appropriate
>>>>>>>> mode switches.
>>>>>>>>
>>>>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>>>>
>>>>>>> Ah, very nice. I tried this before, but my version didn't actually
>>>>>>> work, presumably because I didn't know about the ENDPROC() stuff.
>>>>>>>
>>>>>>> Have you tested this on a machine that has IWMMXT enabled?
>>>>>>>
>>>>>>
>>>>>> No, I don't have access to such a machine, unfortunately.
>>>>>
>>>>> Adding a few mvebu folks to Cc, maybe one of them can test your patch.
>>>>
>>>> Actually even it is a feature of the PJ4 machine non of the mvebu machines
>>>> currently use it. I only see this configuration enabled for the pxa family.
>>>> So I think you would have more feedback with the pxa maintainers/owners.
>>>>
>>>
>>> Are you saying PJ4 should be dropped from 'default' here?
>>
>> Not at all. I didn't find it in the configuration file, but I didn't realized
>> it was because of this "default y".
>>
>> Sorry for the noise.
>>
> 
> Ah, ok.
> 
> In that case, could you perhaps also test this patch on a PJ4 machine
> with multi_v7_defconfig but with CONFIG_THUMB2_KERNEL enabled?

Actually as explained in the commit "ARM: 8040/1: pj4: properly detect
existence of the iWMMXt co-processor", the Armada 370 and Armada XP have
a PJ4B CPU without the iWMMXt extension. The only boards I have using CPus
belonging to the PJ4 family use these SoCs so I wasn't able to fully
tested it. At least I can say that these SoC are now buildable in Thumb
mode with this patch and I didn't see any regression while booting the
system compiled in Thumb2.


> Olof has already done so successfully, but just to be sure.
> 
> Thanks,
> Ard.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
