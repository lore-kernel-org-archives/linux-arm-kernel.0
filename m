From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 16 Oct 2014 10:58:06 -0400 (EDT)
Subject: [PATCH] ARM: Blacklist GCC 4.8.0 to GCC 4.8.2 - PR58854
In-Reply-To: <20141016001801.GQ12379@n2100.arm.linux.org.uk>
References: <E1XeWYh-0004Mw-FC@rmk-PC.arm.linux.org.uk>
 <543EF2B6.1050009@hurleysoftware.com>
 <20141016001801.GQ12379@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1410161052520.9094@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Oct 2014, Russell King - ARM Linux wrote:

> So, let me put this another way: a compiler with this bug is _completely_
> unsuitable for use for compiling programs for use under the Linux
> kernel _as well_ as the Linux kernel itself.
> 
> The difference is that the Linaro compilers come with an expectation
> that they are usable on ARM... whereas stock versions cover a lot more
> and so the ARM arch is probably very small number of their users.
> 
> Hence why I recommend that Linaro takes down their buggy compiler.
> Their 4.8.3 version should not be used *anywhere*, just the same as
> the stock 4.8 to 4.8.2 inclusive should also not be used anywhere on
> ARM either.

Here's the answer from the toolchain team:

On Thu, 16 Oct 2014, Yvan Roux <yvan.roux@linaro.org> wrote:

| Hi Nicolas,
|
| thanks for bringing this to our knowledge.
|
| The fix for PR58854 was included in our releases since the GCC
| 4.8-2013.12 which is based on a 4.8.3 prerelease version (at svn
| revision 205577).  As we are doing monthly releases based on a
| revision of the related FSF branch, using GCC_VERSION (__GNUC__,
| __GNUC_MINOR,__GNUC_PATCHLEVEL) is not accurate enough to identify the
| release version (all our releases between November 2013 and May 2014
| will be 4.8.3) the __VERSION__ predefined macro is a bit more accurate
| here ("4.8.3 20131202 (prerelease)") but not completely satisfactory.
|
| I completely agree that we should at least mention in our impacted
| releases download pages that this bug is present.


Nicolas
