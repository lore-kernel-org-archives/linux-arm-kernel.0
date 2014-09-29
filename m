From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Sep 2014 10:58:03 +0200
Subject: [periperi] How to set default GPIO pin ?
In-Reply-To: <2033766.6tR9OHe7ZC@avalon>
References: <8738cc0vx9.wl%kuninori.morimoto.gx@gmail.com>
 <2862746.g5u9pdpKDi@avalon>
 <CACRpkdb1jF-ro3XcFHFC+Lhgi+0dEHzQYVSSLV6AWnAxiwNLdw@mail.gmail.com>
 <2033766.6tR9OHe7ZC@avalon>
Message-ID: <CACRpkdZg7_edUiAaGq_YPLyT4gCfOcZ8463rYb=hD0Xqr4gOYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 28, 2014 at 11:25 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Linus and Morimoto-san,
>
> On Tuesday 23 September 2014 17:06:28 Linus Walleij wrote:
>> On Wed, Sep 10, 2014 at 10:55 AM, Laurent Pinchart wrote:
>> > On Sunday 31 August 2014 22:08:52 Kuninori Morimoto wrote:
>> >> I know we can use "defalt" PFC settings on DT.
>> >> But, how to use "defalt" GPIO pin settings on DT ?
>> >>
>> >> We would like to use GPIO 7-17 as Low output,
>> >> and do nothing after boot.
>> >
>> > From a DT point of view I believe this is supposed to be done by
>> > specifying the output-low or output-high properties in the pinctrl
>> > configuration node. However, these properties are not supported by the PFC
>> > driver, and there's no easy way for the PFC driver to configure GPIOs
>> > handled by a different driver such as the gpio-rcar driver for instance.
>> >
>> > Linus, do you have any hindsight on how this should be implemented ?
>>
>> I have suggested adding GPIO hogs, so that a GPIO node can specify
>> that some GPIO's specified on the local ship be hogged high or
>> low at probe. Generic DT bindings and generic code in gpiolib.c.
>>
>> gpios-hog-high = <....>;
>> gpios-hog-low = <....>;
>
> How about just a gpios-hog property, with a list of gpio specifiers + flags ?
> That's bikeshedding I suppose.
>
> Morimoto-san, would you like to implement that ? :-)

There was a proposed implementation from Boris BREZILLON, but I was
unhappy with parts of it, however check it and see my comments on
the patch set:
"[RFC PATCH] gpio: add GPIO hogging mechanism"

Yours,
Linus Walleij
