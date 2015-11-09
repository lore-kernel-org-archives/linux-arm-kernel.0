From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Nov 2015 15:36:58 +0100
Subject: [RFC PATCH v6 00/17] ILP32 for ARM64
In-Reply-To: <mvmh9kv1bu8.fsf@hawking.suse.de>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <5795162.dlSUXvq6vJ@wuerfel> <mvmh9kv1bu8.fsf@hawking.suse.de>
Message-ID: <22080083.1SbhEYEXOu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 November 2015 15:33:51 Andreas Schwab wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Monday 09 November 2015 14:23:59 Andreas Schwab wrote:
> >> Yury Norov <ynorov@caviumnetworks.com> writes:
> >> 
> >> > This is what I run:
> >> > https://github.com/norov/glibc/tree/thunderx-ilp32-32time_toff_t
> >> 
> >> That doesn't work for me:
> >> 
> >> ../sysdeps/unix/sysv/linux/generic/sysdep.h:24:22: error: ?__NR_llseek? undeclar
> >> ed (first use in this function)
> >> ../sysdeps/unix/sysv/linux/aarch64/sysdep.h:41:32: error: ?__NR_fcntl64? undeclared (first use in this function)
> >> 
> >
> > Did you re-export the kernel headers that you use as the base?
> 
> I'm using the patched 4.3 kernel headers.

Ok.

>  Why is <asm/bitsperlong.h> defining __BITS_PER_LONG to 64 unconditionally?

It should not, that is a bug. I don't know how Yury built his glibc,
but it can't work if __BITS_PER_LONG is wrong.

	Arnd
