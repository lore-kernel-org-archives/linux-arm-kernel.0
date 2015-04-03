From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 3 Apr 2015 23:04:39 +0200
Subject: [PATCHv5] media: i2c/adp1653: devicetree support for adp1653
In-Reply-To: <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
References: <20150402143846.GA11687@amd> <20150402203417.GA6336@amd>
 <20150403083353.GA21070@amd>
 <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
Message-ID: <20150403210439.GC13009@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +	pd->max_flash_intensity = val/1000;
> > +
> > +	if (of_property_read_u32(child, "max-microamp", &val))
> > +		return -EINVAL;
> > +	pd->max_torch_intensity = val/1000;
> 
> I think you need to do of_node_put(child) here and after you're done with
> indicator below.

...and in most of the error paths. Ok. Will submit the updated patch
when the documentation one is accepted.

Best regards,

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
