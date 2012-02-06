From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 6 Feb 2012 18:37:51 +0100
Subject: [PATCH] ux500 : decouple/recouple gic from the PRCMU
In-Reply-To: <4F2FDF54.8080701@linaro.org>
References: <1328270849-22324-1-git-send-email-daniel.lezcano@linaro.org>
 <4F2F9B2C.8030009@stericsson.com> <4F2FDF54.8080701@linaro.org>
Message-ID: <CACRpkdaW+xBNvEjXe3sYxWq379Gk3HkX66YKe=mWKJMKFercyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2012 at 3:10 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 02/06/2012 10:19 AM, Rickard Andersson wrote:

>> - there is no reason to place these functions inside the db8500-prcmu.c
>> file. There is so much stuff in the PRCMU register base so we can not
>> have everything in one file. Why not have it as it is?
>
> Why spread the prcmu code when it is related to the prcmu ?
>
> Linus ? What do you think ?

I have no strong opinions on this. When I discussed it with Mattias
who wrote much of the driver we concluded that the PRCMU drivers needs
a lot of shaping up. Mainly it may need to be split into two parts: one
which is a "pure" MFD device (register access part) one MFD firmware
interaction part, and then a platform-specific (U8500) part.

This would help getting code in more logical places.

For now I would suggest not moving stuff around, I thin Mattias is onto
cleaning up the structure as per above and we could be messing it up
for him, which is not good.

Yours,
Linus Walleij
