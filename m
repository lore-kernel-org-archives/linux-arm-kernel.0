From: carlo@caione.org (Carlo Caione)
Date: Thu, 9 Jun 2016 13:42:03 +0200
Subject: [PATCH v5 2/3] documentation: Add secure monitor binding
 documentation
In-Reply-To: <20160602171422.GA17166@rob-hp-laptop>
References: <1464520323-19531-1-git-send-email-carlo@caione.org>
 <1464520323-19531-3-git-send-email-carlo@caione.org>
 <20160602171422.GA17166@rob-hp-laptop>
Message-ID: <20160609114203.GA4671@mephisto>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/16 12:14, Rob Herring wrote:
> On Sun, May 29, 2016 at 01:12:02PM +0200, Carlo Caione wrote:

[...]
> > +Example of the node using the secure monitor:
> > +
> > +	#include <dt-bindings/firmware/meson-sm.h>
> > +
> > +	...
> > +
> > +	efuse: efuse {
> > +		compatible = "amlogic,meson-gxbb-efuse";
> > +		secure-monitor = <&sm>;
> 
> Why do you need this? Given there can only be one node, just use 
> of_find_compatible_node();

of_find_compatible_node() in the driver works fine if we have only one
possible compatible property for the secure-monitor node. In this case
we have a different compatible property for each SoC (GXBB in this case)
so I think having the phandle in the DT is still the best thing to do.

Any thought on this Rob?

-- 
Carlo Caione
