From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 11 Apr 2013 19:09:54 +0200
Subject: [PATCH 0/5 v2] mv643xx_eth: device tree bindings
In-Reply-To: <20130411165303.GI28693@titan.lakedaemon.net>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <20130411165303.GI28693@titan.lakedaemon.net>
Message-ID: <CABJ1b_T0uvFgfnXbJH6ut-qj621vX5jhedWdWpHUz1wrs84krg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 6:53 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Thu, Apr 04, 2013 at 12:27:10PM +0200, Florian Fainelli wrote:
>> This patch serie implements mv643xx_eth device tree bindings. I opted for
>> the reuse of the bindings already defined in
>> Documentation/devicetree/bindings/marvell.txt so that we do not create
>> any confusion.
>>
>
> How is the new version of this looking?  Do you think you'll be able to
> get it up in time for DaveM to take it into v3.10?
>
> With this and Thomas' pci series, we will have Kirkwood fully converted
> to devicetree, can begin removing board files, and finally begin
> migrating everything over to mach-mvebu/.  This will lead to the removal
> of five directories under arch/arm/ (plat-orion, mach-kirkwood,
> mach-orion5x, mach-dove, and mach-mv78xx0).

Jason,

I sent Florian an update of some of his patches earlier, based on
cleanup patches I submitted for mv643xx_eth while testing his patch set.
I think, the patch set will play nicely on ARM but without PPC guys involved
in testing it, I guess it will break something there.

Florian is reusing the DT bindings from PPC and they are compatible, but
there parsing is also done within arch/ppc/sysdev/mv64360-dev.c and
maybe somewhere else. The current DT patches for mv643xx_eth will
reparse some properties again (and may break eth on ppc platforms
using mv643xx_eth).

Sebastian
