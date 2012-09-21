From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 21 Sep 2012 20:14:20 +0200
Subject: [PATCH v4 03/10] pinctrl: mvebu: kirkwood pinctrl driver
In-Reply-To: <20120920213636.2ee27d41@skate>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <50559737.8000705@gmail.com>
 <CACRpkdY-Nyn73EJLvE1RsL4hgMRm6hALtnS-eKAXU7edot2V9A@mail.gmail.com>
 <201209201530.40974.arnd@arndb.de>
 <CACRpkdZYr2B83e3mBmMkO8Ai3xU_QGevfbSOSNoTvK3Lz6y6mg@mail.gmail.com>
 <20120920213636.2ee27d41@skate>
Message-ID: <CACRpkdYGjen9xVHHK0ca-4z4uFbuLZq1iJuuUsFssF3Ec4Kx8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 9:36 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> If I understand correctly, we would like drivers to be able to read
> some common "system" registers to figure out which SoC variant we are
> running on. Such feature should normally be provided by code in
> arch/arm/mach-*/ and called by drivers, but we are trying to eliminate
> all dependencies of driver code on architecture code, correct?

So what I think is that any such mechanism would defy the idea
with device tree providing all platform configuration, including
the ASIC/SoC variant.

The only not-so-unelegant idea I have is for the machine to
go in and fiddle with the device tree, e.g. add some info into
the tree somewhere stating into the nodes which ASIC variant
it is. Maybe even modify the compatible value at runtime.

But it somehow feels like cracking an egg with a sledgehammer.

I think we need to meditate on this.

Yours,
Linus Walleij
