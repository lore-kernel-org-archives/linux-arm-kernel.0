From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri, 26 Aug 2016 17:50:33 +0100 (BST)
Subject: [PATCH 0/8] Convert Netgear WNR854T to devicetree
In-Reply-To: <20160826143358.GI25046@lunn.ch>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk> <op.ymsxegsy2s3iss@ecaz>
 <alpine.DEB.2.11.1608261325310.19980@marmot.wormnet.eu>
 <20160826143358.GI25046@lunn.ch>
Message-ID: <alpine.DEB.2.11.1608261703460.19980@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Aug 2016, Andrew Lunn wrote:

>>> - the factory layout gives you almost no space to play with
>
> Given that the kernel has grown in size over the years, does the
> mainline kernel fit in the factory layout?

The factory layout has a 6MB JFFS2 for root & uImage (uboot mounts it 
by default) + 1MB miscellany. So the main restriction on kernel size is 
the size of your userland.

The non-DT mainline layout is 1MB JFFS2 for uImage + 7MB rootfs. Which is 
a closer approximation to other devices with a uImage in it's own 
partition.

>> Of course, one could also argue I'm breaking backwards compatibility
>> at this point by changing it, so maybe I should put it back.
>
> I don't mind breaking backwards compatibility, if the factory defaults
> no longer actually work.....
>
> Also, lets think about the users here. This is a very old box. Anybody
> playing with one are probably of the sort who tinker with a classic
> car in the garage, taking the engine apart and putting it back
> together again. I doubt there are users of this box who take their car
> in for a service once they are out of windscreen washing water.

My line of thinking was that the only people that will see this default 
partition scheme are people that have just compiled a mainline kernel and 
booted it to see what happens. At which point you probably still have the 
Netgear image in Flash. If you had OpenWRT in Flash then in all likelihood 
you'd already be using an OpenWRT kernel too, with it's own flash layout. 
Finally, you could have rolled your own userland and put that on Flash, 
but by then you should know enough to do what you like :)

>
>    Andrew
>

-- 
Jamie Lentin
