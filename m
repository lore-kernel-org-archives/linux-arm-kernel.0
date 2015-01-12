From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Jan 2015 09:24:26 +0100
Subject: [PATCH] Added support for pogoplug e02 (pink/gray)
In-Reply-To: <1421043061-2837-1-git-send-email-ottxor@gentoo.org>
References: <CAA8MNVjieDJ-dv2NNWXK=+uqrPmvtk2EiBYJGJkMugEiN2TsAw@mail.gmail.com>
 <1421043061-2837-1-git-send-email-ottxor@gentoo.org>
Message-ID: <1850772.jTgakZxQFK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 11 January 2015 23:11:01 Christoph Junghans wrote:
> The pogoplug differs from the SheevaPlug only by a
> few details, but especially in the led assignments.
> This patch was tested under Gentoo Linux.
> A version of this patch was included in Arch Linux
> on Arm since Jun 2014:
> https://github.com/archlinuxarm/PKGBUILDs/commit/250c2f0aa6ffe66c0ebda61efaa356e5dc709cc7
> A similar patch is available for OpenWrt:
> https://dev.openwrt.org/browser/trunk/target/linux/kirkwood/patches-3.14/150-pogoplug_e02.patch
> 
> Suggested-by: Felix Kaechele <heffer@fedoraproject.org>
> Suggested-by: Oleg Rakhmanov <moonman.ca@gmail.com>
> Signed-off-by: Christoph Junghans <ottxor@gentoo.org>

Very nice, glad someone found the time to do this. Maybe
I should buy one now ;-)

> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +	};

I'd like to move away from using 'earlyprintk' in dts files.
Can you remove this here and add a 'stdout-path' property that
can be used with 'earlycon'? Unfortunately 3.19 doesn't support
earlycon on ARM yet, but I hope to see that working in 3.20
at last.

	Arnd
