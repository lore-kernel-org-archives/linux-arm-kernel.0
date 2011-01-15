From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Jan 2011 00:02:15 +0000
Subject: [GIT PULL v3] pxa: patches for v2.6.38-rc
In-Reply-To: <20110114214900.GP15996@n2100.arm.linux.org.uk>
References: <AANLkTi=B3sfBXS3vN1+nnRa5m64jiaqmzRFfi6w07dJB@mail.gmail.com>
	<20110114173147.GK15996@n2100.arm.linux.org.uk>
	<20110114214900.GP15996@n2100.arm.linux.org.uk>
Message-ID: <20110115000215.GS15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 09:49:00PM +0000, Russell King - ARM Linux wrote:
> I also need to remove asm/pgtable.h from arch/arm/mach-pxa/generic.c:
>   CC      arch/arm/mach-pxa/generic.o
> In file included from arch/arm/include/asm/pgtable.h:461,
>                  from arch/arm/mach-pxa/generic.c:26:
> include/asm-generic/pgtable.h: In function ?ptep_test_and_clear_young?:
> include/asm-generic/pgtable.h:29: error: dereferencing pointer to incomplete type

Looking through kautobuild, it seems this also affects
arch/arm/mach-sa1100/generic.c too, and is a recently introduced
regression (within the last 24 hours) in mainline.
