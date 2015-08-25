From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Aug 2015 16:34:38 +0200
Subject: [PATCH 6/6] gpiolib: Add gpio name information to
 /sys/kernel/debug/gpio
In-Reply-To: <CAAVeFuKSQP2DYWdhYy-k+cr9F0jc46Q-xuoWXSTguQYaf3SY+w@mail.gmail.com>
References: <1438680203-13432-1-git-send-email-mpa@pengutronix.de>
 <1438680203-13432-7-git-send-email-mpa@pengutronix.de>
 <CACRpkdajd5B6qUa6mi_0m53eMtLenoAWUCnmq-mOC+EhXfzpTA@mail.gmail.com>
 <CAAVeFuKSQP2DYWdhYy-k+cr9F0jc46Q-xuoWXSTguQYaf3SY+w@mail.gmail.com>
Message-ID: <CACRpkdaMw=3JXF4n-u+=x7aSWKnn5rQQ4Xy4afkTL30Q6RHWTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 17, 2015 at 9:29 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Mon, Aug 10, 2015 at 7:02 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Aug 4, 2015 at 11:23 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
>>
>>> Add some information about gpio names to the debugfs gpio file. name and
>>> label of a GPIO are then displayed next to each other. This way it is
>>> easy to see what the real name of GPIO is and what the driver requested
>>> it for.
>>>
>>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>>
>> This patch looks correct in the context.
>
> Looks correct indeed, but on a related note one might question the
> need to have both a "name" and a "label" for a GPIO?

The way I see it a certain GPIO controller has names for the
GPIO lines, like gpio0,1,2...n, while the label is for the actual
use of the GPIO line. It's a bit like the regulator name, rail name
and consumer endpoints guess. Just we only have two names,
not three :P

Yours,
Linus Walleij
