From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Sep 2013 10:20:48 +0200
Subject: [PATCH v2] ARM: omap2: throw the die id into the entropy pool
In-Reply-To: <alpine.DEB.2.02.1309091908270.28435@utopia.booyaka.com>
References: <1378366158-31183-1-git-send-email-linus.walleij@linaro.org>
 <alpine.DEB.2.02.1309091908270.28435@utopia.booyaka.com>
Message-ID: <CACRpkdartxUGNqNkpymecaTrgVrkcDTg9UN7LRiCVRcwnE01Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 9, 2013 at 9:14 PM, Paul Walmsley <paul@pwsan.com> wrote:

> Heh, that function name "add_device_randomness()" is a bit misleading.
> It's not actually intended to add "randomness": from
> drivers/char/random.c:

Yeah you're right...

Tony feel free to edit the commit message when applying.

>  * None of this adds any entropy, it is meant to avoid the
>  * problem of the nonblocking pool having similar initial state
>  * across largely identical devices.

It's noble enough, just a few years back I ran into the problem where
all boards in a test farm came up with the same ethernet MAC
address due to the initialization of the nonblocking pool being
constant.

Yours,
Linus Walleij
