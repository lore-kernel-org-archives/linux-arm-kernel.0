From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jan 2011 23:02:35 +0000
Subject: [GIT PULL] pxa: fixes for 2.6.38-rc
In-Reply-To: <AANLkTim_zbLbN-WD9Fhg+Bgin2QR6ODuNw5ru2R+3hLJ@mail.gmail.com>
References: <AANLkTim_zbLbN-WD9Fhg+Bgin2QR6ODuNw5ru2R+3hLJ@mail.gmail.com>
Message-ID: <20110113230235.GE24149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 03:15:21PM -0600, Eric Miao wrote:
> Hi Russell,
> 
> The following changes since commit aebf2fc9dc974270b4b25a83816c7051c73f07c8:
> 
>   it8152: add IT8152_LAST_IRQ definition to fix build error
> (2011-01-02 23:21:14 +0800)

Nope, not pulling.

I don't have this in my tree, and it doesn't appear to exist in Linus'
tree either.  There is this commit:

commit 823a2df258627b80df2e75056b850424a8eb5fed
Author: Mike Rapoport <mike@compulab.co.il>
Date:   Wed Dec 29 09:06:26 2010 +0200

    ARM: it8152: add IT8152_LAST_IRQ definition to fix build error

    The commit 6ac6b817f3f4c23c5febd960d8deb343e13af5f3 (ARM: pxa: encode
    IRQ number into .nr_irqs) removed definition of ITE_LAST_IRQ which
    caused the following build error:

    CC      arch/arm/common/it8152.o
    arch/arm/common/it8152.c: In function 'it8152_init_irq':
    arch/arm/common/it8152.c:86: error: 'IT8152_LAST_IRQ' undeclared (first use
    arch/arm/common/it8152.c:86: error: (Each undeclared identifier is reported
    arch/arm/common/it8152.c:86: error: for each function it appears in.)
    make[2]: *** [arch/arm/common/it8152.o] Error 1

    Defining the IT8152_LAST_IRQ in the arch/arm/include/hardware/it8152.c
    fixes the build.

    Signed-off-by: Mike Rapoport <mike@compulab.co.il>
    Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

but although it matches the summary, it has a different commit ID.

I smell a rebase of code already merged into mainline, and it stinks.
