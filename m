From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 14 Aug 2011 03:27:05 +0200
Subject: FYI ARM GCC 4.6.x miscompiles the kernel
In-Reply-To: <m3y5ywx602.fsf@intrepid.localdomain>
References: <m3y5ywx602.fsf@intrepid.localdomain>
Message-ID: <201108140327.06726.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, August 14, 2011 01:10:21 AM Krzysztof Halasa wrote:
> Current gcc-4.6.x SVN, ARMEB EABI.

Shouldn't this go to GCC ML too ?

Cheers

> 
> unsigned var[2];
> 
> void test(int arg)
> {
>         unsigned v = *(volatile unsigned *)(&var[arg]);
>         *(volatile unsigned *)(&var[arg]) = v;
> }
> 
> Disassembly of section .text:
> 
> 00000000 <test>:
>    0:   e12fff1e        bx      lr
