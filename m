From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 25 Nov 2015 23:00:59 +0100
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux, atags" entry
In-Reply-To: <17689711.DsQsCiDFAN@wuerfel>
References: <20150713131902.GH26485@atomide.com> <201511252244.28797@pali>
 <17689711.DsQsCiDFAN@wuerfel>
Message-ID: <201511252300.59976@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 22:51:00 Arnd Bergmann wrote:
> On Wednesday 25 November 2015 22:44:28 Pali Roh?r wrote:
> > Arnd, my question about proper solution reminds... Proprietary
> > bootloader which cannot be replaced (e.g. it is signed or do
> > unknown magic) provides information to booted kernel via custom
> > specific ATAGs fields. How userspace could properly read those
> > custom information from bootloader?
> 
> The typical solution for nonstandard bootloaders is to have a boot
> wrapper like the one from
> https://github.com/zonque/pxa-impedance-matcher that translates
> whatever information we have at the bootloader level into DT
> properties.
> 

Ok. So there is no better solution. With some hacks we can use U-Boot as 
3rd stage bootloader. But this is not useful for debugging or 
developing...

Ideal "wrapper" solution would be to compile wrapper and linux zImage 
and then glue them together to one binary. Something like internal linux 
uncompress code which translate atags to dt.

> As I understand, the reason we are not doing that here is that we
> also have proprietary user space that we can't fix to look in a
> different place, i.e. the interface is between the bootloader and
> some user binary, not bootloader to kernel.
> 

Yes, proprietary/closed applications are problems which we cannot fix 
(without rewriting them).

New applications could use new "proper" interface. But without that 
interface we cannot do that.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151125/e61df3a0/attachment.sig>
