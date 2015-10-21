From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Oct 2015 09:43:43 +0200
Subject: Which is better to specify console, "console= " or "stdout-path" ?
In-Reply-To: <CAK7LNAS9uBJ1cVmGBKae3W0tk8Siu1yeXOaeN6Kz11cksMqtsg@mail.gmail.com>
References: <CAK7LNAS9uBJ1cVmGBKae3W0tk8Siu1yeXOaeN6Kz11cksMqtsg@mail.gmail.com>
Message-ID: <4192029.T14mE8UQNd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 October 2015 14:09:42 Masahiro Yamada wrote:
> 
> I think there exist two ways to specify the console port and baudrate.
> 
> 
> [1] Specify console in bootargs
> 
>   chosen {
>         bootargs = "console=ttyS0,115200";
>   };
> 
> 
> [2] Specify stdout-path
> 
>    chosen {
>          stdout-path = "serial0:115200n8";
>    };
> 
> 
> 
> Now I have both in my DTS, but it is redundant.
> 
> So, I want to select either [1] or [2].
> 
> 
> Which is a preferable way?
> 

stdout-path is better. It took us a while to get that implemented
on arm32, but now that it works, we should all use it.

	Arnd
