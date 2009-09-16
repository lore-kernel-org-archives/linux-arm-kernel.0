From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 16 Sep 2009 15:30:59 +0100
Subject: some quesion about assembly when calling fork
In-Reply-To: <3a665c760909160723g75823427t46639d1ae737e483@mail.gmail.com>
References: <3a665c760909160723g75823427t46639d1ae737e483@mail.gmail.com>
Message-ID: <20090916143059.GW13508@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 10:23:40PM +0800, loody wrote:
> Dear all:
> i copy the assembly code as below, I use uclibc.
> 
>        if ((pid = fork()) < 0) {
>     84b4:       ebffffb5        bl      8390 <.text-0x48>
>     84b8:       e1a03000        mov     r3, r0
>     84bc:       e50b3010        str     r3, [fp, #-16]    xx1
>     84c0:       e51b3010        ldr     r3, [fp, #-16]    xx2
>     84c4:       e3530000        cmp     r3, #0  ; 0x0
>     84c8:       aa000002        bge     84d8 <main+0x3c>
>                 printf("fork error");
>     84cc:       e59f0040        ldr     r0, [pc, #64]   ; 8514 <.text
> +0x13c>
>     84d0:       ebffffba        bl      83c0 <.text-0x18>
>     84d4:       ea00000b        b       8508 <main+0x6c>
> 
> why we store r3 and ld it back at the same place in xx1 and xx2.
> does that have any relationship with fork?
> appreciate your help,

It is possible that the compiler is not being told to optimise enough
and that it is failing to spot that it can fold those together, or that
it think there is somewhere else in the code that could branch back
here.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
