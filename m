From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 28 Apr 2018 12:42:04 +0200
Subject: [PATCH 13/17] dt-bindings/interrupt-controller: update Marvell
 ICU bindings
In-Reply-To: <20180427204723.hz2ef5f7fhaid3aj@rob-hp-laptop>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
 <20180421135537.24716-14-miquel.raynal@bootlin.com>
 <20180427204723.hz2ef5f7fhaid3aj@rob-hp-laptop>
Message-ID: <20180428124204.3f305405@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, 27 Apr 2018 15:47:23 -0500, Rob Herring <robh@kernel.org> wrote:

> On Sat, Apr 21, 2018 at 03:55:33PM +0200, Miquel Raynal wrote:
> > Change the documentation to reflect the new bindings used for Marvell
> > ICU. This involves describing each interrupt group as a subnode of the
> > ICU node. Each of them having their own compatible.  
> 
> Why?
> 
> This breaks compatibility.

It does indeed.

The problem comes from the inability to handle multiple MSI parents
for one device and the fact that the API was not designed in this way
at all. I would not risk myself to explain the MSI arcana but I suggest
you to have a look at this thread which led to this series:

https://www.spinics.net/lists/arm-kernel/msg645115.html

Of course I am open to suggestions.

Thanks,
Miqu?l
 
> 
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../bindings/interrupt-controller/marvell,icu.txt  | 60 ++++++++++++++++------
> >  1 file changed, 43 insertions(+), 17 deletions(-)  



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
