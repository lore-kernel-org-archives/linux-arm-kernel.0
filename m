From: ak@linux.intel.com (Andi Kleen)
Date: Wed, 8 Nov 2017 16:02:22 -0800
Subject: [PATCH 13/15] arm64: fix mrs_s/msr_s macros for clang LTO
In-Reply-To: <20171108092555.ta4mkqolunyw6mdr@yury-thinkpad>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-18-samitolvanen@google.com>
 <20171108092555.ta4mkqolunyw6mdr@yury-thinkpad>
Message-ID: <20171109000222.GC8522@tassilo.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> There's the series from Andi Kleen that enables LTO for Linux on x86:
> https://lwn.net/Articles/512548/
> https://github.com/andikleen/linux-misc/tree/lto-411-1
> 
> It has solved many problems you also try to solve, and some patches
> are looking very similar. 
> 
> At now we have different patchsets for gcc and clang, and it would be
> better to have them together. One thing I'm worried is that you introduce
> CONFIG_CLANG_LTO and use it for all cases, including that where more
> generic CONFIG_LTO should be used.

Yes would be good to merge the two. I've been looking at updating
my old one.

I don't cover any ARM code, but lots of generic code. My patches
also worked on MIPS at least.

There's also older patches to enable single-pass-linking for kallsyms,
which is extremly useful for LTO build performance.

-Andi
