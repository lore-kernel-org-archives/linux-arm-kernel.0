From: gang.chen.5i5j@gmail.com (Chen Gang)
Date: Wed, 13 Aug 2014 13:32:14 +0800
Subject: [PATCH v2] arch: Kconfig: Let all little endian architectures
 define CPU_LITTLE_ENDIAN explicitly
In-Reply-To: <20140813050809.GB30459@ravnborg.org>
References: <53EA99C3.90203@gmail.com> <20140813050809.GB30459@ravnborg.org>
Message-ID: <53EAF85E.3000208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/13/14 13:08, Sam Ravnborg wrote:
> On Wed, Aug 13, 2014 at 06:48:35AM +0800, Chen Gang wrote:
>> x86 and ia64 are always little endian. And another architectures may be
>> little endian: mips, sh, powerpc, and m32r (may mark CPU_LITTLE_ENDIAN
>> explicitly); also arm(64) and c6x (which may be !CPU_BIG_ENDIAN).
>>
>> Some drivers (e.g. some of "drivers/isdn/hisax") may only support little
>> endian (CPU_LITTLE_ENDIAN), and some drivers may only support big endian
>> (!CPU_LITTLE_ENDIAN).
>>
>> So export all little endian architectures within kernel wide, so can let
>> Kconfig easier for the modules which only support little endian or only
>> for big endian (assume !CPU_LITTLE_ENDIAN is same as CPU_BIG_ENDIAN).
> We need to cover three cases here:
> - An arch supports only little endian
> - An arch supports only big endian
> - An arch may be both little and big endian
> 

Yeah, we need.

> The solution you suggest assumes that an arch is either little or big endian.
> But we cannot ignore the hybriads that can do both.
> 

For the architectures which can do both, for me, they are: sh, powerpc,
m32r, and mips (may mark CPU_LITTLE_ENDIAN), also are: arm/arm64, and
c6x (may mark !CPU_BIG_ENDIAN).

For the architectures which only support little endian: x86, and ia64.

The left, I assumes they are big endian (no any 'ENDIAN' can be found
in their Kconfig files). In my memory, except related with Intel, all
are (or support) big endian.


Thanks.
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
