From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 30 Sep 2015 13:17:02 -0500
Subject: [PATCH] ARM: fix vdsomunge depends on glibc specific byteswap.h
In-Reply-To: <8B76E3E8-52BF-4803-B1F9-E5704A858870@goldelico.com>
References: <cover.1443628457.git.hns@goldelico.com>
 <2039A9BE-ADA4-4D28-84F4-C8B9D76834AD@goldelico.com>
 <CAKv+Gu_098GVMeJPjDWaQ-uXek_cGUe4UMVy+fMdKw=_C+P7Tg@mail.gmail.com>
 <B6E60776-A054-4749-BCAF-1433BFFC6AF7@goldelico.com>
 <CAKv+Gu_6DibhUUPGrACCZE3S_k50rcO8A5ZcHh5c4UiDQUNApA@mail.gmail.com>
 <560C1DD0.1000907@mentor.com>
 <8B76E3E8-52BF-4803-B1F9-E5704A858870@goldelico.com>
Message-ID: <560C271E.9060103@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30/2015 12:47 PM, H. Nikolaus Schaller wrote:
> 
> Am 30.09.2015 um 19:37 schrieb Nathan Lynch <Nathan_Lynch@mentor.com>:
>>  Why not just use a generic
>> implementation like is found in mips' elf2ecoff?
> 
> Do you have a reference?
> I can't find byte swapping in
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/elf2ecoff.c?id=refs/tags/v4.3-rc3

See the swab16 and swab32 macros (yes, "swab" not "swap").

Or the __constant_swab* macros in include/linux/uapi/swab.h.
