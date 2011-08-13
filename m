From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 14 Aug 2011 01:10:21 +0200
Subject: FYI ARM GCC 4.6.x miscompiles the kernel
Message-ID: <m3y5ywx602.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current gcc-4.6.x SVN, ARMEB EABI.

unsigned var[2];

void test(int arg)
{
        unsigned v = *(volatile unsigned *)(&var[arg]);
        *(volatile unsigned *)(&var[arg]) = v;
}

Disassembly of section .text:

00000000 <test>:
   0:   e12fff1e        bx      lr
-- 
Krzysztof Halasa
