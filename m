From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 20 Apr 2010 10:34:41 +0100
Subject: kernel virtual memory access (from app) does not generate segfault
In-Reply-To: <4BCD7076.9030802@browserseal.com>
References: <4BCD7076.9030802@browserseal.com>
Message-ID: <20100420093441.GD6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 20, 2010 at 12:14:30PM +0300, Sasha Sirotkin wrote:
> More specifically, writing from usermode application to a kernel virtual  
> memory address on ARM does  result in segmentation fault, however  
> calling a function in this memory region for some reason does not.
>
> For instance, this code generates a segfault allright
>
> int * aa;
> aa = 0xc0000000;
> *aa=42;
>
> However this code does not, instead the process simply hangs (and can be  
> killed)
>
> void (*func)(void);
> func = 0xc0000000;
> func();

Your first example writes to an area, your second is execution. IIRC,
this version of the ARM architecture equates read and execute permission
and so you may actually have permission to read this area and thus execute
code in it.

> I stumbled across this by accident. Just curious to understand why it  
> happens. Isn't it a bug ?

Don't think so, other than you might not want that area to be readable
by user space?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
