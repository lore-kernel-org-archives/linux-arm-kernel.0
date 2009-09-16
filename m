From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Wed, 16 Sep 2009 16:38:10 +0200
Subject: some quesion about assembly when calling fork
In-Reply-To: <3a665c760909160723g75823427t46639d1ae737e483@mail.gmail.com>
References: <3a665c760909160723g75823427t46639d1ae737e483@mail.gmail.com> 
Message-ID: <20090916143810.GA24967@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>        if ((pid = fork()) < 0) {
>     84b4:       ebffffb5        bl      8390 <.text-0x48>
>     84b8:       e1a03000        mov     r3, r0
>     84bc:       e50b3010        str     r3, [fp, #-16]    xx1
>     84c0:       e51b3010        ldr     r3, [fp, #-16]    xx2
>     84c4:       e3530000        cmp     r3, #0  ; 0x0

You are not optimizing. So the compiler follows the statements
literally: first it stores the result of fork in pid. Then loads pid to
compare with zero.

If you optimize, I'm sure it won't even copy r0 to r3 before comparing.

/alessandro
