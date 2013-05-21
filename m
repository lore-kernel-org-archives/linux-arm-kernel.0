From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 May 2013 14:17:34 +0100
Subject: [PATCH] arm64: compiling issue for allmodconfig, need
 "asm/parport.h" by "drivers/parport/parport_pc.c"
In-Reply-To: <5199A453.4080402@asianux.com>
References: <5177551D.8090007@asianux.com> <20130424082237.GA23397@arm.com>
 <5177B1F0.10106@asianux.com>
 <20130424102327.GF21850@mudshark.cambridge.arm.com>
 <5177BAD0.9000500@asianux.com> <20130424110511.GK23397@arm.com>
 <5199A453.4080402@asianux.com>
Message-ID: <20130521131734.GD27002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 05:19:31AM +0100, Chen Gang wrote:
> 
> Need add the default file in 'asm/Kbuild' just like arm has done.
> 
> The build command is:
>   make EXTRA_CFLAGS=-W ARCH=arm64 allmodconfig
>   make EXTRA_CFLAGS=-W ARCH=arm64 menuconfig
>     set "aarch64-linux-gnu-" as cross compiling prefix.
>   make EXTRA_CFLAGS=-W ARCH=arm64
> 
> The related error:
>   drivers/parport/parport_pc.c:67:25: fatal error: asm/parport.h: No such file or directory

As I don't see when we'd need this driver, you can probably change the
Kconfig entry (similar to the VGA_CONSOLE one).

Thanks.

-- 
Catalin
