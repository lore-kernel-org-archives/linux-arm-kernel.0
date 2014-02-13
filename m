From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Feb 2014 11:26:09 -0800
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <52F99056.6010906@samsung.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <1540B9A3-2485-4149-81DD-7D86A532E5D4@arm.com>
 <D225ECFF-E2A7-44C9-8D11-20EE77077797@codeaurora.org>
 <2286031.FWmKXGrGIV@wuerfel> <52F99056.6010906@samsung.com>
Message-ID: <CAOesGMgdDnSc=Y8i6JYeGewCh1RPYZ_AxocxKzSD265fa2-yrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 6:52 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 02/13/14 04:14, Arnd Bergmann wrote:
>>
>> On Wednesday 12 February 2014 13:04:40 Kumar Gala wrote:
>>>
>>> On Feb 12, 2014, at 12:12 PM, Catalin Marinas<catalin.marinas@arm.com>
>>> wrote:
>>>>
>>>> On 12 Feb 2014, at 16:25, Kumar Gala<galak@codeaurora.org>  wrote:
>>>>>
>>>>> One reason to keep around ARCH_* is for drivers shared between arm and
>>>>> arm64 that depend on it.
>>>>
>>>>
>>>> We already converted some of them (those depending on ARCH_VEXPRESS) to
>>>> just depend on ARM64. Ideally, at some point I'd like to see them as
>>>> defaulting to modules but I don't think we are there yet (we had some
>>>> discussions at the last KS, I'm not sure anyone started looking into
>>>> this).
>>>
>>>
>>> I'm torn about this, I think for something like VEXPRESS it makes sense,
>>> however I think  its reasonable to still have an config symbol for a full
>>> SoC family or something of that nature.
>>
>>
>> I think for SBSA compliant systems, we should be able to live with a
>> generic ARCH_SBSA Kconfig symbol. For more irregular embedded platforms,
>> we may need something more specific.
>>
> Basically, I agreed with Arnd's suggestion to use ARCH_SBSA. Or we need to
> define level in Kconfig like ARCH_SBSA_L1 for level1. BTW, how about
> compliant with SBSA Level1 and having some specific features?

(It's a little hard to answer since nobody can download the doc and
then talk about it.)

What kind of features are you expecting though? More IP
blocks/devices? Those are just kernel config options to enable,
ideally as modules.

x86 doesn't need config options for each generation of their platform,
and neither should ARM64. Sure, there might be drivers that don't make
sense to enable on some platforms, but that's what defconfigs (or
distro configs), and modules are for -- the modules won't load unless
the hardware is there.

As long as we're not talking about massive amounts of code that is
part of the base platform, separating out per version again doesn't
make sense -- just enable for SBSA and it'll support Level 1 through
whatever. If the kernel size becomes a concern we can revisit, but
let's not start out that way.


-Olof
