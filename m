From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Mar 2014 14:42:48 +0100
Subject: [PATCH 3/3] ARM: kprobes: Fix test code compilation errors for
 ARMv4 targets
In-Reply-To: <53318441.1060306@linaro.org>
References: <1394556894-18592-1-git-send-email-tixy@linaro.org>
 <1394556894-18592-4-git-send-email-tixy@linaro.org>
 <53318441.1060306@linaro.org>
Message-ID: <6485768.fvJS4nr3cP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 March 2014 09:27:29 David Long wrote:
> On 03/11/14 12:54, Jon Medhurst wrote:
> > Conditionally compile kprobes test cases for ARMv5 instructions to avoid
> > compilation errors with ARMv4 targets like:
> >
> > /tmp/cc7Tx8ST.s:16740: Error: selected processor does not support ARM mode `clz r0,r0'
> >
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> 
> This looks OK to me.  Feel free to add my ack.

Ah, I had a similar patch in my 'randconfig-fixes' series. I noticed three
other configurations that are broken with kprobes-test:

- ARMv3 (enabled by ARCH_RPC)
- ARMv7-M (enabled by ARCH_EFM32)
- CPU_ENDIAN_BE32 (enabled by building a big-endian kernel on ARMv5 or older)

Should we treat those the same way, or just disable Kprobes for this case
if nobody cares?

	Arnd
