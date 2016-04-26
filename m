From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Apr 2016 12:41:29 +0200
Subject: [GIT PULL] move ARM LCD display driver to auxdisplay
In-Reply-To: <20160425115758.GA4874@lukather>
References: <CACRpkdbyO0axd5ergYZcXO302f2fFAPKrSNevkvreP1kRjm-vw@mail.gmail.com>
 <20160425115758.GA4874@lukather>
Message-ID: <CACRpkdb=s5onVa7qND9nFUtYPw5H-Hdr7Ja5o3=-9+wxghHekQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2016 at 1:57 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Apr 23, 2016 at 11:43:58AM +0200, Linus Walleij wrote:
>> Hi ARM SoC guys,
>>
>> these two patches move the ARM character LCD driver from
>> misc drivers to the auxdisplay subsystem where it belongs and
>> updates the defconfig for the RealView accordingly.
>>
>> Please pull it into some cleanup branch in the ARM SoC
>> tree.
>>
>> I tried to get some ACK from the auxdisplay maintainer but no
>> reaction.
>
> Auxdisplay is not a new framework, but rather a very old one.
>
> It got introduced in 2.6.21, and only received a couple of drivers
> since.

Small problem for me, but Robin is submitting a brand new
auxdisplay driver:
http://marc.info/?l=linux-kernel&m=146001950512999&w=2
http://marc.info/?l=linux-kernel&m=146001988013230&w=2

> It seems to be quite redundant with fbdev deferred_io, which itself is
> almost deprecated these days.

That is a valid argument for moving cfag12864b* out to
drivers/video/* I guess, but it has nothing to do with this
driver whatsoever.

This driver has nothing to do with fbdev. Nothing at all.
It so not connected to any framebuffer.

This driver gets moved to auxdisplay to match the existing
LCD driver in drivers/auxdisplay/ks0108.c which is a similar
hardware, driving an LCD that likewise has nothing to do
with fbdev.

Yours,
Linus Walleij
