From: ijc@hellion.org.uk (Ian Campbell)
Date: Wed, 29 Aug 2012 10:04:13 +0100
Subject: dreamplug spi partitions
In-Reply-To: <20120828153050.GD19437@titan.lakedaemon.net>
References: <1344498477.11783.38.camel@dagon.hellion.org.uk>
 <20120816142005.GS22226@titan.lakedaemon.net>
 <1345566505.6821.115.camel@zakaz.uk.xensource.com>
 <20120828153050.GD19437@titan.lakedaemon.net>
Message-ID: <1346231053.9975.43.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(lets add the u-boot list, like I should have done in the first place. 
For u-boot@ folks the thread starts at
http://www.spinics.net/lists/arm-kernel/msg188462.html and concerns the
discrepancy between the size of u-boot's environment defined by u-boot
and the kernel)

On Tue, 2012-08-28 at 11:30 -0400, Jason Cooper wrote:
> Before we go changing anything, what is the maximum size a uboot
> environment

grepping for CONFIG_ENV_SIZE in the u-boot source shows examples of
basically every conceivable size. The biggest I could see was 256K. That
seems pretty huge compared to the sorts of things stored in here though
(I expect it happens to be the underlying sector size)

BTW, I see that in u-boot CONFIG_ENV_SECT_SIZE is 64K while
CONFIG_ENV_SIZE is only 4K. Looking at README this would be discouraged
(it's intended to be used to allow u-boot and the env to share a sector,
which is dangerous) but the layout we use doesn't actually overlap
anything.

I've not had much luck googling for the spec of the actual SPI part in
the dreamplug and my one is at home so I can't look for part numbers.

>  or a dtb can be?

Single digit numbers of K seems to be the norm (at least for vexpress
platforms). Allowing for a pretty huge factor for expansion even just 4K
would be enormous (although that strikes me as the sort of statement
which comes back to haunt people ;-)).

>   Until we can nail that down, I'm inclined
> to leave the partitions at their current locations and only adjust the
> size of the environment down to 4k in the kernel.

That sounds sensible.

> This way, a user foolishly attempting to write more than 4k will get an
> error.
> 
> If a user changes out their uboot to get a larger environment, they can
> adjust the dts as well.  No kernel rebuilding necessary.

I hadn't spotted that this was in DTS now (although I should have
guessed). Either way this sounds reasonable to me.

Ian.
-- 
Ian Campbell

How sharper than a hound's tooth it is to have a thankless serpent.
