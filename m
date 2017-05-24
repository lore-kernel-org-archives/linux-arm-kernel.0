From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 May 2017 08:16:20 +0100
Subject: [DT Question] "simple-mfd" DT binding
In-Reply-To: <CAK7LNASGW+D7EyX8dKTwheYwn8LTAdZqaK_EuA5o0eEU9a-L+w@mail.gmail.com>
References: <CAK7LNARQmfX+3RwFgwtvf2Qu79XNX1zh0O741-pPFWS6npytLw@mail.gmail.com>
 <CACRpkdY88Zdp2zqabWPfYPnTwSzYuCqSQHQg9vF_+Zd=TFOvaA@mail.gmail.com>
 <CAK7LNAQ+DimarhHJOg=BqbH+EB19s+wgtRqJ8-XuLKW6_0FFaQ@mail.gmail.com>
 <20170523070547.hhxwrst6np6fpqql@dell>
 <CAK7LNASGW+D7EyX8dKTwheYwn8LTAdZqaK_EuA5o0eEU9a-L+w@mail.gmail.com>
Message-ID: <20170524071620.jk67g6iix4xa7g5w@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 May 2017, Masahiro Yamada wrote:

> Hi Lee,
> 
> 2017-05-23 16:05 GMT+09:00 Lee Jones <lee.jones@linaro.org>:
> > On Tue, 23 May 2017, Masahiro Yamada wrote:
> >
> >> Hi Lee, Linus,
> >>
> >> Thanks for your comments!
> >>
> >> 2017-05-22 17:43 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> >> > On Mon, May 22, 2017 at 3:29 AM, Masahiro Yamada
> >> > <yamada.masahiro@socionext.com> wrote:
> >> >
> >> >> Because "simple-bus" indicates that child nodes are
> >> >> simply memory mapped, but the node "register-bit-led"
> >> >> can not be memory-mapped.
> >> >> So, "simple-mfd" can not be replaced "simple-bus" here.
> >> >
> >> > Yeah... just like Lee points out, you are spot on, this is exactly
> >> > the reason why we created "simple-mfd" in the first place
> >> > IIRC.
> >>
> >> OK, Linux treats simple-bus and simple-mfd in the same way
> >> as far as I see drivers/of/platform.c
> >
> > Correct.  As I said, the functionality of the two are the same.  The
> > difference is their meaning.  Initially we were using "simple-mfd" to

This should have read "simple-bus".

Sorry for any confusion this may have caused.

> > achieve our aim (see below), but there was push-back due to the
> > differences in what the two properties were trying to achieve.  Ergo,
> > we introduced a second property.
> >
> >> Perhaps, can we document the difference between simple-bus and
> >> simple-mfd clearly?
> >> For example, "Unlike simple-bus, it is legitimate that simple-mfd has
> >> subnodes without reg property"
> >>
> >>
> >> I think this is typical when "simple-mfd" is used together with "syscon".
> >> The child devices will use regmap of the parent node.
> >> I'd like to be sure this is valid usage.
> >
> > "simple-mfd" simply means "register all of my child nodes using the
> > platform API without any further intervention".  It's goal is to
> > prevent the MFD subsystem from being stuffed full of drivers where
> > their only purpose is to call of_platform_populate().  All other rules
> > and policy which must be followed are generic DT ones.  To that end, I
> > do not believe making further statements is necessary.
> 
> I see.  Thanks for your kind explanation!

No problem.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
