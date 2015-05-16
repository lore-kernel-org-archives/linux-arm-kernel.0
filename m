From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 May 2015 09:39:32 +0200
Subject: [PATCH 00/14] ARM: berlin: bisect compatible simple-mfd conversion
In-Reply-To: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <46812983.Fkquc1uXKO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 May 2015 02:23:29 Sebastian Hesselbarth wrote:
> This is a patch set reworking Antoine's patches to move Berlin's system and
> chip controller nodes to simple-mfd registered sub-nodes in a bisect compatible
> way.
> 
> Compared to Antoine's patches, I basically first converted the drivers to
> deal with both single node and simple-mfd sub-node registration, then move the
> DT nodes over to simple-mfd, and finally drop the old way of registration.
> 
> I decided to squash the BG2/BG2CD/BG2Q DT changes into a single patch where
> applicable instead of the clock node rework patches. I also left the Acked-by
> from Phillip Zabel (reset), Linus Walleij (pinctrl), and Stephen Boyd (clk)
> in place for the driver changes as the outcome is the same at the end.
> 
> I am still planing to get this into v4.2 as soon as possible, so if Arnd is
> now happy with the dependency of the patches and none of the maintainers is
> against it, I'll prepare a PR next week.
> 
> @Arnd: This is still based on v4.1-rc1 as I cannot see a stable branch for
> simple-mfd support. Anything specific you want me to remind you that this
> depends on simple-mfd?
> 

You should be able to see a drivers/simple-mfd branch in arm-soc.git.
You can base on top of that.

I think it's fine to merge the entire series into our next/drivers branch,
which already has the simple-mfd bits, but you'll still need to rebase
on simple-mfd to make bisection work.

Thanks,

	ARnd
