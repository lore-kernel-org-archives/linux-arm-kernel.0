From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jan 2016 11:23:37 +0100
Subject: [PATCH] of: drop symbols declared by _OF_DECLARE() from modules
In-Reply-To: <CAK7LNATQB1ZBHM26HGSb=hHYsjROppAaOfWGE+M6TvadR71JQg@mail.gmail.com>
References: <1452745987-22146-1-git-send-email-yamada.masahiro@socionext.com>
 <34759085.vISMJm6PEF@wuerfel>
 <CAK7LNATQB1ZBHM26HGSb=hHYsjROppAaOfWGE+M6TvadR71JQg@mail.gmail.com>
Message-ID: <5051214.H38I57Nkpo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 January 2016 19:21:21 Masahiro Yamada wrote:
> Yes, this is my intention.
> 
> I think this patch does so,
> unless I am missing something...
> 
> 
>   #if defined(CONFIG_OF) && !defined(MODULE)
>           __used
>   #else
>           __unused
>   #endif
> 
> 

Ah, got it. You are right, I just missed that because the #else
part was not in the context that I saw in the patch and I was too lazy
to actually look at the file.

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
