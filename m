From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 12:10:40 +0100
Subject: arm64:  dose arm64 support the sysfs system call?
In-Reply-To: <546EE946.1020905@huawei.com>
References: <546EE946.1020905@huawei.com>
Message-ID: <118663792.1vhfOdg7Rq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 15:27:02 wangyufen wrote:
> Hi,
> 
> I did ltp test on arm64, the sysfs testcases failed:
> 
>     sysfs01     0  TWARN  :  This test can only run on kernels that support the sysfs system call
> 
> because the __NR_sysfs didn't define in aarch64
> 
> Dose anyone know what number the sysfs system call is in aarch64?

It's disabled of course, because we don't support ancient libc
implementations. No modern Linux port has this.

	Arnd
