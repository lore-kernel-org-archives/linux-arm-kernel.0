From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Sep 2012 20:00:38 +0200
Subject: [PATCH 05/11] clk: Versatile Express clock generators ("osc")
 driver
In-Reply-To: <1347379848.2497.13.camel@hornet>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-6-git-send-email-pawel.moll@arm.com>
 <20120910191420.20289.1923@nucleus>
 <1347379848.2497.13.camel@hornet>
Message-ID: <CACRpkdZcUuyKpb3EBrdENGnGgZQjbi15Q+21NkF-pVX_Lw_HFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2012 at 6:10 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> On Mon, 2012-09-10 at 20:14 +0100, Mike Turquette wrote:
(...)
>> > +       osc = kzalloc(sizeof(*osc), GFP_KERNEL);
(...)
>> Minor nitpick: the error label tries to free osc, which in this case
>> shouldn't be freed because it is NULL.
>>
>> > +       kfree(osc);
(...)
> $ grep kfree scripts/checkpatch.pl
(...)
> $ grep -B2 kfree Documentation/CodingStyle

Can't you just use devm_kzalloc(&vecdev->dev, ...) and be done with it?

Yours,
Linus Walleij
