From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 22:51 +0100
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux, atags" entry
In-Reply-To: <201511252244.28797@pali>
References: <20150713131902.GH26485@atomide.com> <3245119.krc4KB3uae@wuerfel>
 <201511252244.28797@pali>
Message-ID: <17689711.DsQsCiDFAN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 November 2015 22:44:28 Pali Roh?r wrote:
> 
> Arnd, my question about proper solution reminds... Proprietary 
> bootloader which cannot be replaced (e.g. it is signed or do unknown 
> magic) provides information to booted kernel via custom specific ATAGs 
> fields. How userspace could properly read those custom information from 
> bootloader?

The typical solution for nonstandard bootloaders is to have a boot wrapper
like the one from https://github.com/zonque/pxa-impedance-matcher that
translates whatever information we have at the bootloader level into
DT properties.

As I understand, the reason we are not doing that here is that we also
have proprietary user space that we can't fix to look in a different
place, i.e. the interface is between the bootloader and some user
binary, not bootloader to kernel.

	Arnd
