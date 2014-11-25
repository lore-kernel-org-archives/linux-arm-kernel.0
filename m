From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 25 Nov 2014 13:33:13 +0100
Subject: [PATCH] ARM: PJ4: allow building in Thumb-2 mode
In-Reply-To: <CAOesGMiJruWgt4vmAcQzvQ3X-H6h0UrKGgd_ZbprVtLrO_0_Yw@mail.gmail.com>
References: <1416830200-11114-1-git-send-email-ard.biesheuvel@linaro.org>
 <2078609.NLHB18YoOo@wuerfel>
 <CAKv+Gu_YuHbO7+jusczcJTHF8fM4pF1z2h55BZK0mrHK702z_A@mail.gmail.com>
 <4653047.WBmUTsHC57@wuerfel>
 <CAOesGMhMU+mWVFY20SaS6SXKeJNudzPEGt2h_uc_rFJzMgXmXw@mail.gmail.com>
 <CAKv+Gu90WTfPaoSUgaT4mmoWC--PXrUF8QeE3aDv70Xj99B0Lw@mail.gmail.com>
 <CAOesGMiJruWgt4vmAcQzvQ3X-H6h0UrKGgd_ZbprVtLrO_0_Yw@mail.gmail.com>
Message-ID: <CAKv+Gu8Pa9JnAAfGy-rYh0HPfrB-_PjWinF=veN1gvAKK6K1JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 November 2014 at 19:48, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Nov 24, 2014 at 10:28 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 24 November 2014 at 18:56, Olof Johansson <olof@lixom.net> wrote:
>>> On Mon, Nov 24, 2014 at 9:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> On Monday 24 November 2014 16:34:47 Ard Biesheuvel wrote:
>>>>> On 24 November 2014 at 16:29, Arnd Bergmann <arnd@arndb.de> wrote:
>>>>> > On Monday 24 November 2014 12:56:40 Ard Biesheuvel wrote:
>>>>> >> Two files that get included when building the multi_v7_defconfig target
>>>>> >> fail to build when selecting THUMB2_KERNEL for this configuration.
>>>>> >>
>>>>> >> In both cases, we can just build the file as ARM code, as none of its
>>>>> >> symbols are exported to modules, so there are no interworking concerns.
>>>>> >> In the iwmmxt.S case, add ENDPROC() declarations so the symbols are
>>>>> >> annotated as functions, resulting in the linker to emit the appropriate
>>>>> >> mode switches.
>>>>> >>
>>>>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>> >
>>>>> > Ah, very nice. I tried this before, but my version didn't actually
>>>>> > work, presumably because I didn't know about the ENDPROC() stuff.
>>>>> >
>>>>> > Have you tested this on a machine that has IWMMXT enabled?
>>>>> >
>>>>>
>>>>> No, I don't have access to such a machine, unfortunately.
>>>>
>>>> Adding a few mvebu folks to Cc, maybe one of them can test your patch.
>>>> It's also possible that Olof or Kevin have a PJ4 machine with iwmmxt
>>>> in their boot farms.
>>>
>>> I have a Cubox with Dove, which does implement iWMMXt v2, based on
>>> boot messages.
>>>
>>> I however do not have any kind of userspace programs that make use of
>>> it to test with.
>>>
>>
>> Well, I think the idea is to make sure it doesn't explode when running
>> multi_v7_defconfig in thumb2 mode. That requires a machine that has
>> the actual coprocessor, but as far as I can figure out from the code,
>> this should not require any actual floating point use.
>
> Well, that's easy to confirm, and I've done so now.
>
> Not sure I'd claim that's worth a tested-by though, but whatever:
>
> Tested-by: Olof Johansson <olof@lixom.net>
>

Submitted as 8221/1

Thanks for testing,
Ard.
