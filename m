From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 4 Feb 2010 10:09:13 +0100
Subject: [PATCH] vic: make irq_chip access typesafe
In-Reply-To: <201002021601.43072.hartleys@visionengravers.com>
References: <201002021601.43072.hartleys@visionengravers.com>
Message-ID: <A6D19A13FE030A409EC4362C172E091F0E6ED876@eseldmw101.eemea.ericsson.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When I apply this patch to the latest linux-next
I get the following compile error:

  CC      arch/arm/common/vic.o
/local/scratch/elinwal/linux-next/arch/arm/common/vic.c: In function
'vic_init_arm':
/local/scratch/elinwal/linux-next/arch/arm/common/vic.c:338: error: 'i'
undeclared (first use in this function)
/local/scratch/elinwal/linux-next/arch/arm/common/vic.c:338: error:
(Each undeclared identifier is reported only once
/local/scratch/elinwal/linux-next/arch/arm/common/vic.c:338: error: for
each function it appears in.)
make[3]: *** [arch/arm/common/vic.o] Error 1
make[2]: *** [arch/arm/common] Error 2

However if I just add an int i; at the beginning of the offending
function U300 boots and runs like a charm, so given that you
fix this it's
Tested-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
