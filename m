From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 22 Jan 2010 09:19:23 +1300
Subject: Use of data types in new portings
In-Reply-To: <2703439e1001170502x5faa39fbm57cbedf7403b41c9@mail.gmail.com>
References: <2703439e1001170502x5faa39fbm57cbedf7403b41c9@mail.gmail.com>
Message-ID: <1264105163.23727.790.camel@macbook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-01-17 at 22:02 +0900, Khushhua Mogambo wrote:
>   I starting to port Linux kernel to my companies new ARM based
> SoC and development board.
> 
> Some of the regs is 16bits wide and some is 32bits width. I ask if
> my using u16 and u32 in place of 'unsigned short' and 'unsigned int'
> in the whole porting would be acceptable or not?
> 
> In different wording, using only u16 and u32 always is considered good
> quality or bad? 

Personally, I always prefer to avoid the the 'u16' and 'u32' nonsense
types in favour of the proper C types 'uint16_t' and 'uint32_t'.

There is a small amount of justification for the __u16 and __u32
variants, in headers which are exposed to userspace.... but only if you
believe that you really _have_ to avoid exposing the proper C types to
the users because everything will break if you include <stdint.h> for
them. Which is not really true.

If you have types which are explicitly sized and _must_ be 16-bit or
32-bit, then by all means use a sized type (u16 or preferably uint16_t).
Otherwise, stick with normal types.

-- 
dwmw2
