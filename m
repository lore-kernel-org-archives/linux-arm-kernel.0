From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 19 Feb 2016 17:57:17 +0100
Subject: [PATCH v2 0/5] arm64: kernel: Add support for User Access Override
In-Reply-To: <CAFEAcA_uAG1hX2a3n8FSJpB704wzJeXzijHSETJ2B6OR0g=nJw@mail.gmail.com>
References: <1454684330-892-1-git-send-email-james.morse@arm.com>
 <20160218180313.GE2538@e104818-lin.cambridge.arm.com>
 <CAFEAcA9SQjg3GpDpU-Tt8i+JiOcJWQKTNzwLLTC4imiBuiP6+w@mail.gmail.com>
 <20160219164606.GD12864@e104818-lin.cambridge.arm.com>
 <CAFEAcA_uAG1hX2a3n8FSJpB704wzJeXzijHSETJ2B6OR0g=nJw@mail.gmail.com>
Message-ID: <CAKv+Gu9GDE5MVLGkvx9NGB=R_AS--32aGYQ++zT9gGFwBFgnpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 February 2016 at 17:54, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 19 February 2016 at 16:46, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> On Fri, Feb 19, 2016 at 03:38:44PM +0000, Peter Maydell wrote:
>>> This is more of a heads-up than a demand that you Do Something,
>>> but perhaps somebody has a clever idea...
>>
>> Only if Qemu had its own MIDR/REVIDR ;) (and patch the instruction like
>> other errata workarounds).
>
> Smiley noted, but FWIW the relevant CPUs advertise themselves as
> MIDR 0x411fd070 REVIDR 0 (A57) and MIDR 0x410fd034 REVIDR 0 (A53),
> and it should be harmless to patch the ID_AA64MMFR2 read to always
> return 0 on any A53 or A57 including h/w, because they'll read as
> zero anyway...
>
> So it comes down to how much we want to work around QEMU "errata".
>

Doesn't this only affect TCG emulation, and not KVM?
