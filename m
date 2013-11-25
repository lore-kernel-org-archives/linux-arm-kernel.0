From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Nov 2013 17:39:00 +0000
Subject: [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs
In-Reply-To: <528F95FE.7080406@wwwdotorg.org>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com>
 <1384853593-32202-3-git-send-email-hdoyu@nvidia.com>
 <20131121131558.E5B82C40A2C@trevor.secretlab.ca>
 <528E5932.1070105@wwwdotorg.org>
 <20131122074111.155E2C40753@trevor.secretlab.ca>
 <528F95FE.7080406@wwwdotorg.org>
Message-ID: <20131125173900.GB28201@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 05:35:58PM +0000, Stephen Warren wrote:
> On 11/22/2013 12:41 AM, Grant Likely wrote:
> > It seems more that IOMMU attachment is closer to being a property of the
> > bus rather than a property of the device itself. In that context it
> > would make more sense for the bus device to hold off child device
> > registration or probing until the IOMMU is available. That keeps the
> > logic out of both the core code and the individual device drivers.
> 
> The bus structure that DT and Linux know about is the register bus.
> There's no reason that devices have to emit their master transactions
> onto that same bus, or onto only that same bus.

Agreed. Dave (CC'd) and I actually had a lot of discussion around the DT bus
abstractions last week and we ended up with a binding that looked sane enough
to start a meaningful discussion in this area.

Dave -- care to post what we came up with? It certainly has a bunch of
overlap with the IOMMU problems being discussed here.

Will
