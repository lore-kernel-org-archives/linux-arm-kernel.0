From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Apr 2015 23:11:33 +0200
Subject: [PATCH 5/9] ARM: BCM2836: Add io map initialization for bcm2836.
In-Reply-To: <87oamh9q12.fsf@eliezer.anholt.net>
References: <1429639796-2169-1-git-send-email-eric@anholt.net>
 <6559239.zHhRM8VZWD@wuerfel> <87oamh9q12.fsf@eliezer.anholt.net>
Message-ID: <60195891.q3RtUhgfkn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 April 2015 13:37:13 Eric Anholt wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Tuesday 21 April 2015 11:09:52 Eric Anholt wrote:
> >> +static struct map_desc bcm2836_io_map __initdata = {
> >> +       .virtual = BCM2835_PERIPH_VIRT,
> >> +       .pfn = __phys_to_pfn(BCM2836_PERIPH_PHYS),
> >> +       .length = BCM2835_PERIPH_SIZE,
> >> +       .type = MT_DEVICE
> >> +};
> >> +
> >>  static void __init bcm2835_map_io(void)
> >>  {
> >> -       iotable_init(&io_map, 1);
> >> +       iotable_init(&bcm2835_io_map, 1);
> >> +}
> >> +
> >> +static void __init bcm2836_map_io(void)
> >> +{
> >> +       iotable_init(&bcm2836_io_map, 1);
> >>  }
> >> 
> >
> > Can you explain what this is needed for? Most platform ports don't
> > do this any more.
> 
> Nope, I can't!  I'm not sure what the bcm2835 side of it does, and I was
> just replicating that for 2836.
> 
> Should it be removed from 2835, too?
> 

Hard to know. Does anything reference BCM2835_PERIPH_VIRT? Does it work
if you remove it?

	Arnd
