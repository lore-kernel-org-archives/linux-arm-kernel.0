From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Oct 2017 23:36:14 +0200
Subject: [GIT PULL] DTS updates for the Integrator PCIv3 driver
In-Reply-To: <CACRpkdYQeOVy=g2K5dE1FErUvAGj+p+bTh8kr4uFhb-VLrXChA@mail.gmail.com>
References: <CACRpkdZ0X1OiC6gogxD9EGkoMbY2yy81PPyrTWU-74ego9m+vQ@mail.gmail.com>
 <CACRpkdYQeOVy=g2K5dE1FErUvAGj+p+bTh8kr4uFhb-VLrXChA@mail.gmail.com>
Message-ID: <CAK8P3a1BRqJpu36xbVjpDG__NY4BLx1NoBvg26n5s9wQATr85w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 11:25 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Wed, Sep 27, 2017 at 11:24 PM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>
>> Hi ARM SoC folks,
>>
>> these are some three patches readying the Integrator/AP device tree to work
>> properly with the modernized and corrected PCIv3 driver.
>>
>> Please pull them in for DTS changes.
>
>   ARM: dts: Update Integrator/AP PCI v3 compatible (2017-09-27 23:11:16 +0200)
>
> ----------------------------------------------------------------
> These are the DTS file changes required to fix bugs and satisfy
> requirements for the new PCIv3 driver in the PCI subsystem.
> The binding changes have been merged to the PCI tree.

Pulled into next/dt.

Just a word of caution here: this is strictly speaking an incompatible
binding change, which we normally don't do. I suppose we can make
an exception for Integrator, as it is a very rare and old platform that
doesn't have a lot of users, and in particular none that ship with
a DT blob. Anyway it would be better to be explictit about that in both
the patch changelog and the pull request.

I've added a few words to the merge commit changelog for this.

       Arnd
