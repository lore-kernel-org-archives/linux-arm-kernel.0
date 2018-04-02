From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 2 Apr 2018 22:21:01 +0900
Subject: [Question] MFD driver that handles clocks/resets and populates
 child nodes
In-Reply-To: <20180402120414.GA8159@lunn.ch>
References: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
 <20180402120414.GA8159@lunn.ch>
Message-ID: <CAK7LNAQ6LKk3NtGLB8g07ocyvXidpTHsApeDuctvEHyyLvk2ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-02 21:04 GMT+09:00 Andrew Lunn <andrew@lunn.ch>:
>> The maintainer of DWC3, Felipe Balbi, requested to
>> split the glue layer driver into small parts such as
>> reset, regulator, phy, etc.
>
> What exactly did Felipe ask for? Did he ask that the patch be split
> up, one patch per reset, regulator, phy etc?


Yeah.  That is what we understood from his comments.


These are the feed-backs from him.

https://lkml.org/lkml/2018/1/23/298
https://lkml.org/lkml/2018/1/24/352




> Are all these resources used just by the DWC3? Or is it a true MFD,
> multiple functions?

I do not think this is a real MFD.

This is a DWC3 glue layer, i.e.
a collection of misc registers that control
the DWC3 IP.


Just splitting it into small pieces
to use PHY, reset, regulator framework in Linux.

Of course, the price of this approach
is so cluttered Device Tree,
honestly I do not like it much.



>
>          Andrew
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
