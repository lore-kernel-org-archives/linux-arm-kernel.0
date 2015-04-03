From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Sat, 4 Apr 2015 00:39:33 +0300
Subject: [PATCHv6] media: i2c/adp1653: Documentation for devicetree
 support for adp1653
In-Reply-To: <20150403202624.GA4308@amd>
References: <20150402143846.GA11687@amd> <20150402203417.GA6336@amd>
 <20150403083353.GA21070@amd>
 <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
 <20150403202624.GA4308@amd>
Message-ID: <20150403213933.GP20756@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 10:26:24PM +0200, Pavel Machek wrote:
> > > +  - power-gpios: Reference to the GPIO that controls the power for the chip.
> > 
> > You're using power-gpios in documentation only.
> 
> Which is ok, because generic code adds "-gpios" itself.

Do you think you need this part:

+       if (!of_find_property(node, "gpios", NULL)) {                           
+               dev_err(&client->dev, "No gpio node\n");                        
+               return -EINVAL;                                                 
+       }                                                                       


-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
