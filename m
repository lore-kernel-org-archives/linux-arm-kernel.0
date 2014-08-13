From: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 12 Aug 2014 23:51:34 -0700
Subject: [PATCH v2] arch: Kconfig: Let all little endian architectures
 define CPU_LITTLE_ENDIAN explicitly
In-Reply-To: <53EAF85E.3000208@gmail.com>
References: <53EA99C3.90203@gmail.com> <20140813050809.GB30459@ravnborg.org>
 <53EAF85E.3000208@gmail.com>
Message-ID: <53EB0AF6.6060208@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2014 10:32 PM, Chen Gang wrote:
> 
> Yeah, we need.
> 
>> The solution you suggest assumes that an arch is either little or big endian.
>> But we cannot ignore the hybriads that can do both.
>>
> 
> For the architectures which can do both, for me, they are: sh, powerpc,
> m32r, and mips (may mark CPU_LITTLE_ENDIAN), also are: arm/arm64, and
> c6x (may mark !CPU_BIG_ENDIAN).
> 
> For the architectures which only support little endian: x86, and ia64.
> 
> The left, I assumes they are big endian (no any 'ENDIAN' can be found
> in their Kconfig files). In my memory, except related with Intel, all
> are (or support) big endian.
> 

I'm quite certain that is wrong.  From memory, for example, I believe
CRIS is littleendian, and sure enough:

: tazenda 103 ; less arch/cris/include/uapi/asm/byteorder.h
#ifndef _CRIS_BYTEORDER_H
#define _CRIS_BYTEORDER_H

#include <linux/byteorder/little_endian.h>

#endif

As far as I know, endianism is always a compile-time option on Linux, so
we should be able to relatively easily define the architecture so that
we either have hardwired littleendian, bigendian, or prompt.

	-hpa
