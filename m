From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 9 Nov 2015 19:04:41 +0300
Subject: [RFC PATCH v6 00/17] ILP32 for ARM64
In-Reply-To: <20151109155042.GA3550@yury-N73SV>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <5795162.dlSUXvq6vJ@wuerfel> <mvmh9kv1bu8.fsf@hawking.suse.de>
 <22080083.1SbhEYEXOu@wuerfel>
 <4C408453-CDE5-4564-8D22-E59296F2045C@gmail.com>
 <20151109155042.GA3550@yury-N73SV>
Message-ID: <20151109160441.GA6451@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 06:50:42PM +0300, Yury Norov wrote:
> On Mon, Nov 09, 2015 at 10:52:32PM +0800, pinskia at gmail.com wrote:
> > 
> > 
> > > On Nov 9, 2015, at 10:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > 
> > >> On Monday 09 November 2015 15:33:51 Andreas Schwab wrote:
> > >> Arnd Bergmann <arnd@arndb.de> writes:
> > >> 
> > >>>> On Monday 09 November 2015 14:23:59 Andreas Schwab wrote:
> > >>>> Yury Norov <ynorov@caviumnetworks.com> writes:
> > >>>> 
> > >>>>> This is what I run:
> > >>>>> https://github.com/norov/glibc/tree/thunderx-ilp32-32time_toff_t
> > >>>> 
> > >>>> That doesn't work for me:
> > >>>> 
> > >>>> ../sysdeps/unix/sysv/linux/generic/sysdep.h:24:22: error: ?__NR_llseek? undeclar
> > >>>> ed (first use in this function)
> > >>>> ../sysdeps/unix/sysv/linux/aarch64/sysdep.h:41:32: error: ?__NR_fcntl64? undeclared (first use in this function)
> > >>> 
> > >>> Did you re-export the kernel headers that you use as the base?
> > >> 
> > >> I'm using the patched 4.3 kernel headers.
> > > 
> > > Ok.
> > > 
> > >> Why is <asm/bitsperlong.h> defining __BITS_PER_LONG to 64 unconditionally?
> > > 
> > > It should not, that is a bug. I don't know how Yury built his glibc,
> > > but it can't work if __BITS_PER_LONG is wrong.
> > 
> > 
> > Looks like I had changed the header file manually for building glibc and Yury and myself missed that when  he updated the patches. 
> > 
> > 
> > Thanks,
> > Andrew
> > 
> > > 
> > >    Arnd
> 
> 
> No, it's my fault. I forgot to add a patch that sets __BITS_PER_LONG
> to 32. I'll send it here now.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-arm64-uapi-set-__BITS_PER_LONG-correctly-for-ILP32-a.patch
Type: text/x-diff
Size: 1414 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151109/ac1de216/attachment.bin>
