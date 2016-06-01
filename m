From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 01 Jun 2016 09:49:51 +0200
Subject: [PATCH] ARM: uniphier: drop code for old DT binding
In-Reply-To: <CAK7LNAT0n=VdfOmZ0dHaoVbD9jEsa16tY__9sVkuuuStMYA7WA@mail.gmail.com>
References: <1464682628-12163-1-git-send-email-yamada.masahiro@socionext.com>
 <4992506.m4GEHIOqdc@wuerfel>
 <CAK7LNAT0n=VdfOmZ0dHaoVbD9jEsa16tY__9sVkuuuStMYA7WA@mail.gmail.com>
Message-ID: <6243293.lmvRqvQAd6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 1, 2016 3:30:03 PM CEST Masahiro Yamada wrote:
> Hi Arnd.
> 
> 2016-05-31 18:21 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> > On Tuesday, May 31, 2016 5:17:08 PM CEST Masahiro Yamada wrote:
> >> Commit 307d40c56b0c ("ARM: uniphier: rework SMP code to support new
> >> System Bus binding") added a new DT binding for SMP code, but still
> >> kept old code for the backward compatibility.
> >>
> >> Linux 4.6 was out with both bindings supported, so it should not
> >> hurt to drop the old code now.
> >>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >>
> >
> > That explanation is in general not sufficient. Are you sure that
> > nobody is shipping a machine with their own dts file that is not
> > merged upstream, and that there are no bootloaders that have a
> > hardcoded dtb file that we need to support indefinitely?
> >
> 
> I have to confess that almost no one (except me) uses this upstreamed
> code directly.
> It can boot, but it is almost useless for practical uses (at least for
> production level)
> because it still lacks lots of drivers.
> 
> Our products based on ARM 32bit SoCs were shipped with old kernel
> (without device tree) that were never upstreamed.

That's fine, a lot of companies work like this when the upstreaming
starts, just mention this in the changelog.

> Socionext is now trying to change the development procedure
> and the situation will be much better for ARM64 SoC products; it will be
> more community-based development, although they are not shipped yet.
> 
> So, the answer is,  nobody is shipping ARM32 products using this upstream code.
> Device Tree is not used in the first place.
> (But, I still believe I should keep upstreaming.)

Ok.

	Arnd
