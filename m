From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 26 Jun 2018 09:29:31 +0200
Subject: [PATCH v2 06/23] thermal: armada: convert driver to syscon
 register accesses
In-Reply-To: <20180626033724.q7radxgjeqtsl7ae@tarshish>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-7-miquel.raynal@bootlin.com>
 <20180626033724.q7radxgjeqtsl7ae@tarshish>
Message-ID: <20180626092931.7f0f0ad4@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Tue, 26 Jun 2018 06:37:24 +0300, Baruch Siach <baruch@tkos.co.il>
wrote:

> Hi Miquel,
> 
> On Mon, Jun 25, 2018 at 05:12:22PM +0200, Miquel Raynal wrote:
> > Until recently, only one register was referenced in MVEBU thermal IP
> > node. Recent changes added a second entry pointing to another
> > register right next to it. We cannot know for sure that we will not
> > have to access other registers. That will be actually the case when
> > overheat interrupt feature will come, where it will be needed to access
> > DFX registers in the same area.
> > 
> > This approach is not scalable so intead of adding consinuously memory
> > areas in the DT (and change de DT bindings, while keeping backward  
> 
> s/de/the/

Oh and s/intead/instead/ too.

Thanks for pointing it,
Miqu?l
