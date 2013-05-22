From: gang.chen@asianux.com (Chen Gang)
Date: Wed, 22 May 2013 08:45:45 +0800
Subject: [PATCH] arm64: compiling issue for allmodconfig,
 need "asm/parport.h" by "drivers/parport/parport_pc.c"
In-Reply-To: <20130521131734.GD27002@arm.com>
References: <5177551D.8090007@asianux.com> <20130424082237.GA23397@arm.com>
 <5177B1F0.10106@asianux.com>
 <20130424102327.GF21850@mudshark.cambridge.arm.com>
 <5177BAD0.9000500@asianux.com> <20130424110511.GK23397@arm.com>
 <5199A453.4080402@asianux.com> <20130521131734.GD27002@arm.com>
Message-ID: <519C1539.10908@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2013 09:17 PM, Catalin Marinas wrote:
> On Mon, May 20, 2013 at 05:19:31AM +0100, Chen Gang wrote:
>>
>> Need add the default file in 'asm/Kbuild' just like arm has done.
>>
>> The build command is:
>>   make EXTRA_CFLAGS=-W ARCH=arm64 allmodconfig
>>   make EXTRA_CFLAGS=-W ARCH=arm64 menuconfig
>>     set "aarch64-linux-gnu-" as cross compiling prefix.
>>   make EXTRA_CFLAGS=-W ARCH=arm64
>>
>> The related error:
>>   drivers/parport/parport_pc.c:67:25: fatal error: asm/parport.h: No such file or directory
> 
> As I don't see when we'd need this driver, you can probably change the
> Kconfig entry (similar to the VGA_CONSOLE one).
> 

Oh, really it is, it is for PC, it seems except x86, no one else will
use it. And for x86, it will be less and less used, in the future.

It seems it is a better candidate than VGA_CONSOLE. I will define
CONFIG_HAVE_PARPORT_PC for it.  :-)

Thanks.
-- 
Chen Gang

Asianux Corporation
