From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Fri, 23 Jan 2015 01:30:11 +0100
Subject: [PATCHv5 2/2] INPUT: Introduce generic trigger/LED pairs to
 input LEDs
In-Reply-To: <20150123001038.GA2940@type.youpi.perso.aquilenet.fr>
References: <20141226232116.GA5069@type> <20141226232310.GD5069@type>
 <20150104232838.GA14912@dtor-glaptop>
 <20150123001038.GA2940@type.youpi.perso.aquilenet.fr>
Message-ID: <20150123003011.GC3123@type.youpi.perso.aquilenet.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samuel Thibault, le Fri 23 Jan 2015 01:10:38 +0100, a ?crit :
> Dmitry Torokhov, le Sun 04 Jan 2015 15:28:38 -0800, a ?crit :
> > > +	dev = cdev->dev->platform_data;
> > 
> > Umm, platform data is not the best place for storing this. Why not drvdata?
> 
> Ah, actually led_classdev already makes use of it, see the
> device_create_with_groups call in led_classdev_register.

Actually I'd say it makes sense to be using the platform_data field:
from the point of view of the led object, the input object is indeed
something like a platform.

Samuel
