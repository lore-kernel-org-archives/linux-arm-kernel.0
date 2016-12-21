From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 22 Dec 2016 00:39:21 +0900
Subject: [PATCH] i2c: uniphier[-f]: fix bool logic calculation
In-Reply-To: <1482256538.1984.23.camel@perches.com>
References: <1476851911-21729-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNATrR9dSuuUZR98f=uOZqSGqUBnUNZmrUqUZgubHHE+X4A@mail.gmail.com>
 <1482256538.1984.23.camel@perches.com>
Message-ID: <CAK7LNAS7DaG-Ath1-qzA3C6WLNV=YiSCjgDnsOH4-eS0yt04Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,


2016-12-21 2:55 GMT+09:00 Joe Perches <joe@perches.com>:
> On Wed, 2016-12-21 at 01:20 +0900, Masahiro Yamada wrote:
>> Hi.
>>
>> I have not got any comment, but does this seem
>> a right thing to do?
>
>> This code is working, but it should not depend on how "bool" is
>> typedef'ed, or the bit position of I2C_M_RD.
>
> <shrug>
>
> I think bool can be guaranteed to be _Bool.
>
> So a change not necessary as the original code
> has a c90 guarantee of the same result.
>
> 6.3.1.2 Boolean type
> 1
> When any scalar value is converted to _Bool, the result is 0 if the value compares equal
> to 0; otherwise, the result is 1.
>

Thanks for your comments!

_Bool works very nicely.

I have seen some (not very nice) projects
that define like "typedef char bool;"

So, I was wondering if I should write code
that works regardless how bool is defined.
Just my two cents.

-- 
Best Regards
Masahiro Yamada
