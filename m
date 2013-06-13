From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 13 Jun 2013 17:36:00 +0200
Subject: [PATCH 1/2] pinctrl: add function to parse generic pinconfig
 properties from a dt node
In-Reply-To: <201306131723.04721.heiko@sntech.de>
References: <201306102139.32444.heiko@sntech.de>
 <CACRpkdb-vbdQJOeZvCEsKLatK-0BhEfUTJqmGURJGf1NWx__Ew@mail.gmail.com>
 <201306131635.21446.heiko@sntech.de>
 <201306131723.04721.heiko@sntech.de>
Message-ID: <CACRpkdZavNX3jk4K5unEJCED4vTuZEUF=NC1naGOMyr54hXQKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 5:23 PM, Heiko St?bner <heiko@sntech.de> wrote:

>> Ok, I'll see that I get this fixed :-)
>
> Hmm ... what is the meaning of the argument of bias-disable and bias-high-
> impedance, as the kernel-doc in pinconf-generic.h does not tell?

I think those arguments are N/A, ignored, doesn't matter.
If these options were typed, they would be bool.

Please improve documentation if you can... sorry for all the
rough edges.

> bias-bus-hold ignores its argument and we already clarified that the pull-* do
> have != 0 or 0 argument.

I think in the DT binding, both these forms:

bias-pull-up;
bias-pull-up = <150000>;

Should be allowed.

So when parsing, you first check if it exists, then if there
is an argument, if there is no value supplied, just set it
to 1, as that is clearly != 0...

Yours,
Linus Walleij
