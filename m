From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 3 Feb 2016 21:41:21 +0100
Subject: [PATCH 0/3] kallsyms: remove special handling for CONFIG_ARM
In-Reply-To: <CAKv+Gu_50f+yqs20a6j_QyCg3NcSfe5cD00fWXebLXBFhV_eGg@mail.gmail.com>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <HKXPR06MB0565A2CFF95AD7C000F43E6A8ADF0@HKXPR06MB0565.apcprd06.prod.outlook.com>
 <CAKv+Gu9VvskQ34w0niS+6AtF9hNcycfYDt_3Kp4T+WK8Vxf_dA@mail.gmail.com>
 <HKXPR06MB05656F902E0E1FBBDBD713DC8AD00@HKXPR06MB0565.apcprd06.prod.outlook.com>
 <CAKv+Gu8ZTHAqviveLMizRKPfeXwb6kcXi4cVQNYVYuPcVMgMeQ@mail.gmail.com>
 <20160203200107.GD10826@n2100.arm.linux.org.uk>
 <CAKv+Gu_MyPvDnnQ0hScqW6XR77h0MD6LxEb_q2Z-mS0AQw3djA@mail.gmail.com>
 <alpine.LFD.2.20.1602031522090.17825@knanqh.ubzr>
 <CAKv+Gu_50f+yqs20a6j_QyCg3NcSfe5cD00fWXebLXBFhV_eGg@mail.gmail.com>
Message-ID: <CAKv+Gu_p9QaK31h5K0t=ZQ1HYRgbjH3tsZ8hG5fZ=-vJCiKSaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 February 2016 at 21:30, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 3 February 2016 at 21:23, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> On Wed, 3 Feb 2016, Ard Biesheuvel wrote:
>>
>>> On 3 February 2016 at 21:01, Russell King - ARM Linux
>>> <linux@arm.linux.org.uk> wrote:
>>> > On Wed, Feb 03, 2016 at 02:41:29PM +0100, Ard Biesheuvel wrote:
>>> >> > bf353edc T __stubs_start
>>> >>
>>> >> This is a global symbol
>>> >>
>>> >> > bf353edc T _etext
>>> >> > bf353ee0 t __stubs_start
>>> >>
>>> >> This is a local symbol
>>> >
>>> > Stop this madness.  This gets you an immediate NAK on the patch set.
>>> >
>>>
>>> What madness? This does not change at all with my patches, these
>>> duplicates already exist in the current code.
>>
>> That doesn't make it any better, and was cause for issue as Chris
>> demonstrated.  Can we get rid of that duplication please?
>>
>
> 4/4 in my v2 removes the redundant symbols.

... actually, that only removes the redundant __stub_start, and the
redundant __vectors_start is already removed in patch #1. Patch #4
(v2) may be shot down for other reasons, in that case I can simply
move the removal of __stubs_start to patch #1 instead.
