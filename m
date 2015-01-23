From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 22 Jan 2015 16:51:16 -0800
Subject: [PATCHv5 2/2] INPUT: Introduce generic trigger/LED pairs to input
 LEDs
In-Reply-To: <20150123004429.GD3123@type.youpi.perso.aquilenet.fr>
References: <20141226232116.GA5069@type> <1756449.aIckN0M451@dtor-glaptop>
 <20150123004429.GD3123@type.youpi.perso.aquilenet.fr>
Message-ID: <4596566.1GHUcIZaFc@dtor-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, January 23, 2015 01:44:29 AM Samuel Thibault wrote:
> Dmitry Torokhov, le Thu 22 Jan 2015 16:37:02 -0800, a ?crit :
> > On Friday, January 23, 2015 01:30:11 AM Samuel Thibault wrote:
> > > Samuel Thibault, le Fri 23 Jan 2015 01:10:38 +0100, a ?crit :
> > > > Dmitry Torokhov, le Sun 04 Jan 2015 15:28:38 -0800, a ?crit :
> > > > > > +	dev = cdev->dev->platform_data;
> > > > > 
> > > > > Umm, platform data is not the best place for storing this. Why not
> > > > > drvdata?
> > > > 
> > > > Ah, actually led_classdev already makes use of it, see the
> > > > device_create_with_groups call in led_classdev_register.
> > > 
> > > Actually I'd say it makes sense to be using the platform_data field:
> > > from the point of view of the led object, the input object is indeed
> > > something like a platform.
> > 
> > No, platform data is what difefrentiates an arm board from another arm
> > board, or an x86 or mips one.
> 
> From the point of view of a device connected to that board, yes. But
> from the point of view of LEDs connected to a keyboard, the platform is
> the keyboard.

No. Please take a look at other users of platform data. Platform is the box we 
are running on, not parent device. Platform data is supposed to be constant,
not changing between driver runs.

Thanks.

-- 
Dmitry
