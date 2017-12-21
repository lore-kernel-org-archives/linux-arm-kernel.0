From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Dec 2017 07:29:42 -0800
Subject: [PATCH 1/9] dt-bindings: ti-sysc: Update binding for timers and
 capabilities
In-Reply-To: <20171220181051.eoftsww6463hyak3@rob-hp-laptop>
References: <20171215180900.3243-1-tony@atomide.com>
 <20171215180900.3243-2-tony@atomide.com>
 <20171216183059.ipsftfnvsyamv6fd@rob-hp-laptop>
 <20171216192222.GH3875@atomide.com>
 <20171220181051.eoftsww6463hyak3@rob-hp-laptop>
Message-ID: <20171221152942.GT3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [171220 18:13]:
> On Sat, Dec 16, 2017 at 11:22:22AM -0800, Tony Lindgren wrote:
> > I was planning to have "ti,sysc-delay-us" only in the driver, but
> > the same IP needs it set on dm814x while not on omap4 for OTG
> > for example. I could add SoC specific quirks to the driver
> > for that one if you prefer that instead?
> 
> No, I don't have a preference.

OK

> > > Are the bits you've defined all of them or there's more?
> > 
> > That's it, with this binding I've allocated the data from dts
> > for the tests I've done. So that should allow us to replace the
> > static data to start with as seen with the following command:
> > 
> > $ git grep -A10 "struct omap_hwmod_class_sysconfig" \
> > 	arch/arm/*hwmod*data*.c
> > ...
> > 
> > So that's to configure a big pile of different module
> > configurations we currently have as can be seen with:
> > 
> > $ git grep "struct omap_hwmod_class_sysconfig" \
> > 	arch/arm/*hwmod*data*.c | wc -l
> > 194
> > 
> > I'm sure there's still few duplicates there though..
> 
> Okay, then I guess I'm okay with this.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

OK thanks for the review.

Regards,

Tony
