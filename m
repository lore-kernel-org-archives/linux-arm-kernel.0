From: clabbe@baylibre.com (LABBE Corentin)
Date: Tue, 17 Jul 2018 13:16:30 +0200
Subject: [PATCH v3 4/9] dt-bindings: ata: ahci-platform: document AHCI
 reset
In-Reply-To: <20180716155416.GA32497@rob-hp-laptop>
References: <1531479786-4911-1-git-send-email-clabbe@baylibre.com>
 <1531479786-4911-5-git-send-email-clabbe@baylibre.com>
 <20180716155416.GA32497@rob-hp-laptop>
Message-ID: <20180717111630.GA7900@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2018 at 09:54:16AM -0600, Rob Herring wrote:
> On Fri, Jul 13, 2018 at 11:03:01AM +0000, Corentin Labbe wrote:
> > This patch document the new optional resets for ahci node.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/ata/ahci-platform.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> > index 5f362af2724c..a5281d7557e3 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> > +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> > @@ -34,6 +34,8 @@ Optional properties:
> >  - phys              : reference to the SATA PHY node
> >  - phy-names         : must be "sata-phy"
> >  - ahci-supply       : regulator for AHCI controller
> > +- resets            : phandle to the reset line of AHCI controller
> > +                      If set, must have a reset-names set as "ahci"
> 
> A name is pointless if there is only one. Also, the name should be what 
> the signal in the block is called which I doubt would be called "ahci". 
> A likely name is some form of reset, resetn, etc. which again is 
> pointless to name if there is only 1.
> 
> If you do have 'reset-names' then that needs to be listed too like 
> phy-names.
> 

Since the ahci-platform code is common to lots of different drivers, I must have a name otherwise I could grab a reset which wasnt for me.
See the revert of f0f56716fc3e ("ata: ahci-platform: add reset control support") for example.

So the code need to grab a name, and since this name could be used by other people I took the generic "ahci".

In my case (R40), the reset is called sata, so I will change reset-names to "sata" in my next serie.

Regards
