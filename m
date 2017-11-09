From: maxim.kuvyrkov@linaro.org (Maxim Kuvyrkov)
Date: Thu, 9 Nov 2017 07:48:06 +0300
Subject: [PATCH 13/15] arm64: fix mrs_s/msr_s macros for clang LTO
In-Reply-To: <20171109000222.GC8522@tassilo.jf.intel.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-18-samitolvanen@google.com>
 <20171108092555.ta4mkqolunyw6mdr@yury-thinkpad>
 <20171109000222.GC8522@tassilo.jf.intel.com>
Message-ID: <DAE9979D-29B4-4BD3-99E5-0E8273A7F8E0@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Nov 9, 2017, at 3:02 AM, Andi Kleen <ak@linux.intel.com> wrote:
> 
>> There's the series from Andi Kleen that enables LTO for Linux on x86:
>> https://lwn.net/Articles/512548/
>> https://github.com/andikleen/linux-misc/tree/lto-411-1
>> 
>> It has solved many problems you also try to solve, and some patches
>> are looking very similar. 
>> 
>> At now we have different patchsets for gcc and clang, and it would be
>> better to have them together. One thing I'm worried is that you introduce
>> CONFIG_CLANG_LTO and use it for all cases, including that where more
>> generic CONFIG_LTO should be used.
> 
> Yes would be good to merge the two. I've been looking at updating
> my old one.
> 
> I don't cover any ARM code, but lots of generic code. My patches
> also worked on MIPS at least.
> 
> There's also older patches to enable single-pass-linking for kallsyms,
> which is extremly useful for LTO build performance.

[Yury, thanks for the CC:]

Chiming in from the toolchain side, Linaro's Toolchain team will try to help with any GCC or Clang issues that are exposed by building kernel with LTO on arm64 / arm.

Regarding CONFIG_* options, I would expect most of the configuration changes to be equally valid for both GCC's and Clang's LTO support.  Sami, I don't think it's fair to ask you to support both Clang and GCC in your patchset, but, where changes are obviously toolchain-agnostic, could you use CONFIG_LTO?  And use CONFIG_LTO_CLANG for Clang-specific parts?

This way we will be able to avoid most of the refactoring when adding support for GCC's LTO.

Thank you,

--
Maxim Kuvyrkov
www.linaro.org
