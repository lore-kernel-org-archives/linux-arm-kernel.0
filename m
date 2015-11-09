From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Nov 2015 15:21:58 +0100
Subject: [RFC PATCH v6 00/17] ILP32 for ARM64
In-Reply-To: <mvmlha71f2o.fsf@hawking.suse.de>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <20151105221842.GA30634@yury-N73SV> <mvmlha71f2o.fsf@hawking.suse.de>
Message-ID: <5795162.dlSUXvq6vJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 November 2015 14:23:59 Andreas Schwab wrote:
> Yury Norov <ynorov@caviumnetworks.com> writes:
> 
> > This is what I run:
> > https://github.com/norov/glibc/tree/thunderx-ilp32-32time_toff_t
> 
> That doesn't work for me:
> 
> ../sysdeps/unix/sysv/linux/generic/sysdep.h:24:22: error: ?__NR_llseek? undeclar
> ed (first use in this function)
> ../sysdeps/unix/sysv/linux/aarch64/sysdep.h:41:32: error: ?__NR_fcntl64? undeclared (first use in this function)
> 

Did you re-export the kernel headers that you use as the base?

The earlier ABI used 64-bit off_t with 'lseek()' and no loff_t, while this
one does uses loff_t with 'llseek()' etc on the kernel side and does not
provide the off_t based syscalls.

	Arnd
