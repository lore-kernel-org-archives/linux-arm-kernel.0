From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 8 Jun 2017 10:46:28 +0900
Subject: [PATCH] clk: sunxi-ng: Move all clock types to a library
In-Reply-To: <20170607081708.ycruditlhebizzt2@flea.lan>
References: <20170602223006.1653-1-sboyd@codeaurora.org>
 <201706031243.qNvuUbQX%fengguang.wu@intel.com>
 <20170605144546.b6oh5sygrza22hbe@flea.lan>
 <CAK8P3a1Qvt4nvM5HeK-n87tsi2D5GBOmZo0rZv_Lp==CC=34Uw@mail.gmail.com>
 <CAGb2v66QvLdojDe4+uG9Opa7fApA-GH9pW4v0En5j6QSPf1yZw@mail.gmail.com>
 <CAK8P3a38TyiHXBgB0DQka=0iASuyJO_zMrczXqYBiJj6LEnNWg@mail.gmail.com>
 <20170607081708.ycruditlhebizzt2@flea.lan>
Message-ID: <CAK7LNAQUTiM3DoD3_NCOA-95_LQ0P2m-CXDSQAKJ+eON5fAuYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-06-07 17:17 GMT+09:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> On Wed, Jun 07, 2017 at 09:36:34AM +0200, Arnd Bergmann wrote:
>> On Wed, Jun 7, 2017 at 7:45 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>> > at the bottom (with a comment) would be cleaner, and
>> > we wouldn't need to modify all the existing lines.
>> > AFAIK about Makefiles, that should work?
>>
>> Ah, yes. That's much better.
>>
>>       Arnd
>
> I just applied the original patch, with that addition, and a comment
> as suggested by Stephen.
>


Hmm, I think Kbuild expects lib.a only for the final link
(at least in official level)
Is it a problem to compile common files all the time?

# Common objects
obj-y += ccu_common.o
obj-y += ccu_reset.o


We may end up with some unused functions in vmlinux,
but it will not be a big impact on the image size in this case.

CONFIG_LD_DEAD_CODE_DATA_ELIMINATION may
take care of unused symbols.  I have not tested this CONFIG, though.



-- 
Best Regards
Masahiro Yamada
