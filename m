From: buildroot@browserseal.com (Sasha Sirotkin)
Date: Tue, 20 Apr 2010 12:14:30 +0300
Subject: kernel virtual memory access (from app) does not generate segfault
Message-ID: <4BCD7076.9030802@browserseal.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More specifically, writing from usermode application to a kernel virtual 
memory address on ARM does  result in segmentation fault, however 
calling a function in this memory region for some reason does not.

For instance, this code generates a segfault allright

int * aa;
aa = 0xc0000000;
*aa=42;

However this code does not, instead the process simply hangs (and can be 
killed)

void (*func)(void);
func = 0xc0000000;
func();

I stumbled across this by accident. Just curious to understand why it 
happens. Isn't it a bug ?


P.S. My kernel is 2.6.32.7 and the CPU is ARM926EJ-S rev 5 (v5l)
