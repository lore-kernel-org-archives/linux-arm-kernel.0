From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 21 May 2017 04:03:19 +0900
Subject: [PATCH] usb: remove NULL pointer check for clk_disable_unprepare
In-Reply-To: <1495302733-6669-1-git-send-email-yamada.masahiro@socionext.com>
References: <1495302733-6669-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAShnH+n7ejrQSqwE8EycDTvqAaVVo-9LCvUdT1qCBTv8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-05-21 2:52 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> After long term efforts of fixing non-common clock implementations,
> clk_disable() is a no-op for a NULL pointer input, and this is now
> tree-wide consistent.
>
> All clock consumers can safely call clk_disable(_unprepare) without
> NULL pointer check.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Sorry, I retract this patch.

Krzysztof pointed out
cleanups only for clk_disable_unprepare() will lose the code symmetry.

NULL pointer checks for clk_prepare_enable() should be
removed to keep the code symmetrical.

This is possible for common-clock framework because
clk_prepare_enable() is also a no-op for a NULL clk input.
But it is not necessarily true for non-common clock implementations.



-- 
Best Regards
Masahiro Yamada
