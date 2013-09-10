From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Sep 2013 10:14:59 +0200
Subject: Inte IOP Xscale updates
In-Reply-To: <CAA9_cmcMLooT6=+PwR9rx4ALmNeKG=qXWn+K_dLJ+CVj9u6tYA@mail.gmail.com>
References: <CACRpkdZU5mVU15AK=m-BRmpizKJJVAR98JKf3Qcgy2ms+HG+Hw@mail.gmail.com>
 <CAA9_cmcMLooT6=+PwR9rx4ALmNeKG=qXWn+K_dLJ+CVj9u6tYA@mail.gmail.com>
Message-ID: <CACRpkdbLbB_TGbBfCvNzesAP5cB6irk8m=D4kD6n2RTYE0mAnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 12:10 AM, Dan Williams <dan.j.williams@intel.com> wrote:

> I have not been following device-tree conversions for how they handle
> legacy boot loaders?

That is handled by way of the appended device tree.

With such platforms I use this:

--enable USE_OF
--enable ARM_APPENDED_DTB
--enable ARM_ATAG_DTB_COMPAT
--enable PROC_DEVICETREE

Then:

cat foo.dtb >> zImage

And it should appear in /proc/devicetree

The resulting zImage can be wrapped into a uImage
if U-boot is used, I use this method too.

> ...I'll just start with reviewing your gpio conversion.

Thanks :-)

Yours,
Linus Walleij
