From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Oct 2014 10:58:15 +0200
Subject: [PATCH v2 4/4] ARM: dts: mt8135: Add pinctrl node for mt8135.
In-Reply-To: <1412260136.4875.9.camel@pengutronix.de>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <1411443545-24951-5-git-send-email-srv_hongzhou.yang@mediatek.com>
 <CACRpkda-K7w-bY0uSdnZvzEKEeQg38oExoHPSW61kEv9Wv20mA@mail.gmail.com>
 <20140924124044.GC4992@pengutronix.de>
 <CACRpkdbtN-BDEwpJO2swnOjCe3UJhD5WOXXKBV0hPOe2M2=k7Q@mail.gmail.com>
 <1412260136.4875.9.camel@pengutronix.de>
Message-ID: <CACRpkdZv30EAH2vzyfaOQQ4uzEjQ8DwSSHiPr-TsbWUMDmHj7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 2, 2014 at 4:28 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Donnerstag, den 02.10.2014, 16:02 +0200 schrieb Linus Walleij:

>> > Agreed for standardized device tree bindings, but not for using strings.
>>
>> What is the alternative? Device Tree is very much about strings,
>> as is shown by the pin config bindings.
>>
> Mhm, maybe we are still talking about different things but I just don't
> get your point. Traditionally DT is more about plain numbers than
> strings. Look at the early examples of PCI or other bus bindings,
> defined back in the IEEE 1275 days. Almost everything back then has
> been mapped to plain numbers.
>
> Using strings only bloats the DT, not only in it's source form, but also
> as a compiled DTB. (...)

OK I think we have arrived (in this thread and in others) to the old
discussion of whether to use groups or per-pin function setting in
drivers.

Let us move forward like this:

I have proposed a general binding of functions+groups (as strings)
which will be suitable for some.

What would you propose as a general binding for systems using
per-pin configuration?

My problem as a subsystem maintainer is that there are too many
custom bindings. We need to standardize on something.

For pin config we have attained some consensus, and that is indeed
using strings "bias-pull-up" etc, simply because there is no
sane way to enumerate them all, and it is simple to read by
humans.

Yours,
Linus Walleij
