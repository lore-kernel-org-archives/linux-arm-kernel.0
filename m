From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 19 Jul 2014 11:10:25 +0200
Subject: [PATCH v3 1/3] asm-generic/io.h: Implement generic {read,
 write}s*()
In-Reply-To: <20140719085338.GB31564@ravnborg.org>
References: <1405508484-18303-1-git-send-email-thierry.reding@gmail.com>
 <5913515.3g98ODuH6W@wuerfel> <20140719085338.GB31564@ravnborg.org>
Message-ID: <5140022.LHa9ZBVSGJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 19 July 2014 10:53:38 Sam Ravnborg wrote:
> 
> Then there are the other type where one IO access function
> may re-use the implementation of another IO access function:
> 
>     #ifndef writeb
>     #define writeb __raw_writeb
>     #endif
> 
> This could have been implmented like this:
> 
> #ifndef writeb
> #define writeb writeb
> static inline void writeb(u8 b, volatile void __iomem *addr)
> {
>    __raw_writeb(b, addr);
> }
> #endif
> 
> In this way the prototype of the function is easy to understand and
> we avoid the macro tricks were we blindly replace one function name,
> with another function name.
> And we also use the same pattarn all over for the various functions.
> 
> Concerning the efficiency the compiler should be smart enough to
> do the same independent on the two implmentations.

I really don't have a strong opinion on those, as you say one is a
little shorter and the other is a little more readable, so my
preference in a case like this is to leave it up to the person
who last touches the code and let them decide.

	Arnd
