From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Feb 2013 15:09:21 +0100
Subject: [PATCH 6/9] gpiolib: use descriptors internally
In-Reply-To: <20130209091729.978C73E1A18@localhost>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-8-git-send-email-acourbot@nvidia.com>
 <CACRpkdbib-+pvMiLQN=f6d-1dhK2OK3znJeGoL7rDxDQYuJRuA@mail.gmail.com>
 <CAAVeFu+phNtzzj7rw96g9iH8sj9gGqd5SfAqtkDHvu3PeL_oQA@mail.gmail.com>
 <20130209091729.978C73E1A18@localhost>
Message-ID: <CACRpkdagLssOG3FW8Qr1zqFabGMgdupADwg1=c0eQ7e76_XM5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 9, 2013 at 10:17 AM, Grant Likely <grant.likely@secretlab.ca> wrote:

> The ERR_PTR()/IS_ERR() is a horrible pattern for code
> readability because it breaks the expectations that programmers have for
> what is and is not a bad pointer. There are decades of history where the
> test for a bad pointer is 'if (!ptr)'. Not only does ERR_PTR make make
> that test not work, but the compiler won't tell you when you get it
> wrong.
>
> There are places where ERR_PTR makes sense. Particularly when
> communicating with userspace where error codes have very specific
> meanings, but I don't want it in the GPIO subsystem.

OK I disagree but you get to decide.

However if you take this all the way to the descriptor API
it will make the consumer (driver) API for GPIO descriptors deviate
from what is today used for clocks, regulators and pins.

With all the resulting confusion for users.
I've seen worse subsystem deviations though.

Yours,
Linus Walleij
