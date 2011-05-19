From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 19 May 2011 16:31:24 +0100
Subject: [PATCH v2] arm: Add Cortex A5 proc info
In-Reply-To: <000d01cc162e$723081b0$56918510$@deacon@arm.com>
References: <1305720361.17656.44.camel@hornet.cambridge.arm.com>
	<1305737066-11900-1-git-send-email-pawel.moll@arm.com>
	<000d01cc162e$723081b0$56918510$@deacon@arm.com>
Message-ID: <1305819084.17656.63.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Please can you do the same for the __v7_proc_info struct? 

Yeah, I could if we want to... The thing is that the macro will have to
take full ID and mask value then. And a name for the structure. So extra
3 parameters. Not a big deal I suppose.

> On top of that, I think you should take optional, additional HWCAPs as
> arguments to the macro which get ORd with the base v7 HWCAPs. 

Em, the "optional" bit here is a problem. I can't just do

#define INFO(_a, _extra_hwcaps...) \
	.long HWCAP | _extra_hwcaps;


Because the output would be ".long HWCAP | ;" when no _extra_hwcaps are
given... Unless I'm missing some preprocessor trick? :-)

> This might be useful for A15 where we have integer division.

What HWCAP would this be? I've checked Catalin's repo and the only
difference I've spotted between A9 and A15 proc info were the mmu
flags...

Cheers!

Pawe?
