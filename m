From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Jun 2018 16:15:29 +0200
Subject: [PATCH 0/5] RFC: Mezzanine handling for 96boards
In-Reply-To: <CAKv+Gu-gAkfRsEUOc=iyxi6Twvg9cbvWNqNHRS2HzUDZg8xUhg@mail.gmail.com>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
 <CAK8P3a2KqoX-squhGc8TBuJ==8xxELsuy-H+c1+C7Fu7Z4OjDA@mail.gmail.com>
 <CAKv+Gu-gAkfRsEUOc=iyxi6Twvg9cbvWNqNHRS2HzUDZg8xUhg@mail.gmail.com>
Message-ID: <CAK8P3a3f6=APcwKERWA4owv7j_gFEqo1tmFtUtVeP82do-QhDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 3:22 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 18 June 2018 at 14:21, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Mon, Jun 18, 2018 at 9:45 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Also, given that we can (and do) already describe topologies involving
> mezzanines by ignoring the connector altogether (which is not entirely
> unreasonable given the fact that we [as Linaro/96boards] dropped the
> ball on this one and did not mandate discoverability for mezzanines).
> So ideally, DTs can be expressed such that older kernels can still use
> those peripherals.

Not sure. Modeling the connector as a device with its own driver does
seem like a significant advantage, which to me weighs more than backward
compatibility with old kernels. We can clearly always describe the devices
behind the connector individually and ignore the connector on old kernels
and we should still allow running DT files that work with the old kernels
on new kernels, but I don't see running new DT files on old kernels as
essential in this case. Many platforms don't actually care about that case
at all today (but some do of course).

      Arnd
