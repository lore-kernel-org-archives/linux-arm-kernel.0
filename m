From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Sep 2012 18:17:23 +0200
Subject: [PATCH v3 1/9] pinctrl: mvebu: pinctrl driver core
In-Reply-To: <20120912180154.3e620d18@skate>
References: <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347266386-16229-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20120911164409.4c030bd8@skate> <504FB869.60201@wwwdotorg.org>
 <20120912085423.21af58d5@skate>
 <CACRpkdYVMTbfA++eqRrq6JM0phjN-X-f3N==oXbyVxCyYUVOOA@mail.gmail.com>
 <20120912180154.3e620d18@skate>
Message-ID: <CACRpkdaKFNbgure6ZVfBktQobAv4RJAJXd37wBAeTY19jKqtPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 6:01 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> See for example
> http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6281_OpenSource.pdf,
> which is the hardware datasheet for the 88F6281 Marvell SoC (Kirkwood
> family). Table 26 on page 53 of the PDF is a good example. It lists all
> the pins, on per row, and then has columns for each function identifier
> (from 0x0 to 0x7). Then each cell says when pin X is muxed in function
> Y, it provides this functionality.
>
> So clearly, this representation is a list of pins, and for each pin, a
> list of possible functions that this pin can take.

OK the ux500 datasheet looks more or less the same. What I did was
to define the groups that made sense for each column (our columns are
named a,b,c), so you can see the result in
drivers/pinctrl/pinctrl-nomadik-db8500.c

In your case I would have defined groups like this:

#define PIN_MPP18 18
#define PIN_MPP19 19
(...)
static const struct pinctrl_pin_desc nmk_db8500_pins[] = {
        PINCTRL_PIN(PIN_MPP18, "MPP[18]"),
        PINCTRL_PIN(PIN_MPP19, "MPP[19]"),
(...)
};
static const unsigned mpp_1_pins[] = { PIN_MPP18, PIN_MPP19);

Then I'd register this as a group, then map the groups to
functions.

But maybe this is just stupid in your case, you'd have to tell.
(Maybe it's my driver that sucks, I don't know.)

Linus Walleij

Yours,
Linus Walleij
