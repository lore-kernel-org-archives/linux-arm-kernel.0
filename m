From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Jan 2013 13:31:35 -0800
Subject: [GIT PULL] Nomadik devicetree and cleanups
In-Reply-To: <CACRpkdZM8+6QaGrRtCCMWoZQO23uej7JDr1xz2zG7TtwQ7Ngqw@mail.gmail.com>
References: <CACRpkdZM8+6QaGrRtCCMWoZQO23uej7JDr1xz2zG7TtwQ7Ngqw@mail.gmail.com>
Message-ID: <20130128213135.GA3047@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 10:19:16AM +0100, Linus Walleij wrote:
> Hi ARM SoC guys,
> 
> This patch series converts the Nomadik to use Device Tree.
> 
> Changes outside of the subsystem are constrained to pinctrl (my subsystem
> and thus OK:ed) and a oneline in drivers/mtd/nand/fsmc_nand.c adding
> a new compatible value.
> 
> The MTD maintainers have had time enough to ACK that oneliner and it
> shouldn't be a big issue, so:
> 
> Please pull this into your tree.

Hi,

Sorry for a late feedback on this, but after merging, this doesn't seem to
build due to lack of vic_of_init symbol visibility (i.e. it's exported out of
drivers/irqchip/irq-vic.c, but it's not actually defined in any header file.

Also, a couple of small merge conflicts with the timer and irq cleanup
branches.

Would you mind rebasing on top of the depends/cleanup branch in arm-soc, sort
out the breakage (and test it) and resubmit?


Thanks!

-Olof
