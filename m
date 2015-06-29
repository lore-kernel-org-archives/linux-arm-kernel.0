From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 29 Jun 2015 13:06:47 +0200
Subject: [PATCH RFC 0/4] PL08x DT bindings and LPC18xx DMA support
In-Reply-To: <CACRpkdZZBGzioO25-Sov0CVK8JuRp1uuJDEZKFtLxg9WwsSzww@mail.gmail.com>
References: <1434280937-8369-1-git-send-email-manabian@gmail.com>
 <CACRpkdZZBGzioO25-Sov0CVK8JuRp1uuJDEZKFtLxg9WwsSzww@mail.gmail.com>
Message-ID: <CAGhQ9VxXHdPwUR0AWC8SVA9iRV8pazVC1atmrEKzP5dJx81MBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 29 June 2015 at 12:53, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Jun 14, 2015 at 1:22 PM, Joachim Eastwood <manabian@gmail.com> wrote:
>
>> This patch set aims to add support for DMA on the NXP LPC18xx/43xx
>> (Cortex-M3/M4) platform. The platform has a PL080 controller with a
>> mux in front of the DMA request lines. This setup is quite common
>> and can be found on most other, if not all, NXP LPC devices.
>
> Nice!
>
>>  - remove channel sub-nodes from driver and dt doc.
>
> Why? It was a good approach for the Nomadik. Well I'll look
> how you do it for NXP, I guess it makes total sense for you.

Since the bus specifier (AHB1 / AHB2) property has been moved into the
DMA cell, I don't see a reason to keep channel sub-nodes stuff.

And I also agree with Arnd's other comments on the subject here:
https://www.marc.info/?l=linux-arm-kernel&m=141088461506806&w=2
(see at the bottom)

Summary:
* No other driver does this.
* Removing it make the driver a bit simpler.


regards,
Joachim Eastwood
