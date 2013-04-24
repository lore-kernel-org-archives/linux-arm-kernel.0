From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 24 Apr 2013 18:51:22 +0800
Subject: [PATCH v2] arm64: compiling issue, need add include/asm/vga.h file
In-Reply-To: <20130424104231.GJ23397@arm.com>
References: <5177551D.8090007@asianux.com> <20130424082237.GA23397@arm.com>
 <5177B1F0.10106@asianux.com> <20130424104231.GJ23397@arm.com>
Message-ID: <5177B92A.5030004@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?04?24? 18:42, Catalin Marinas wrote:
> On Wed, Apr 24, 2013 at 11:20:32AM +0100, Chen Gang wrote:
>> For compiling with allmodconfig, need vga.h file, so generate it which
>> just only include the asm-generic one.
>>
>> It is firstly used by drivers/gpu/drm/drm_irq.c.
>>
>> The related error:
>> include/video/vga.h:22:21: fatal error: asm/vga.h: No such file or directory
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/arm64/include/asm/vga.h |   21 +++++++++++++++++++++
>>  1 files changed, 21 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/vga.h
> 
> As Will said, please use asm/Kbuild.
> 

OK, I will send.

>> diff --git a/arch/arm64/include/asm/vga.h b/arch/arm64/include/asm/vga.h
>> new file mode 100644
>> index 0000000..1c49d51
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/vga.h
>> @@ -0,0 +1,21 @@
>> +/*
>> + * Copyright (C) 2012 ARM Ltd.
> 
> ARM copyright? You either work for ARM or there is a copyright
> assignment between you and ARM ;)
> 

:-)

-- 
Chen Gang

Asianux Corporation
