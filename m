From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu, 5 Jul 2018 17:53:46 +0200
Subject: [PATCH v2 06/23] thermal: armada: convert driver to syscon
 register accesses
In-Reply-To: <20180705144333.2cf0fe6a@xps13>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-7-miquel.raynal@bootlin.com>
 <20180626033724.q7radxgjeqtsl7ae@tarshish>
 <20180626092931.7f0f0ad4@xps13>
 <20180702172918.GA28262@localhost.localdomain>
 <20180705144333.2cf0fe6a@xps13>
Message-ID: <20180705175346.0ff7a906@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eduardo,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Thu, 5 Jul 2018
14:43:33 +0200:

> Hi Eduardo,
> 
> Eduardo Valentin <edubezval@gmail.com> wrote on Mon, 2 Jul 2018
> 10:29:19 -0700:
> 
> > Miquel,
> > 
> > On Tue, Jun 26, 2018 at 09:29:31AM +0200, Miquel Raynal wrote:  
> > > Hi Baruch,
> > > 
> > > On Tue, 26 Jun 2018 06:37:24 +0300, Baruch Siach <baruch@tkos.co.il>
> > > wrote:
> > >     
> > > > Hi Miquel,
> > > > 
> > > > On Mon, Jun 25, 2018 at 05:12:22PM +0200, Miquel Raynal wrote:    
> > > > > Until recently, only one register was referenced in MVEBU thermal IP
> > > > > node. Recent changes added a second entry pointing to another
> > > > > register right next to it. We cannot know for sure that we will not
> > > > > have to access other registers. That will be actually the case when
> > > > > overheat interrupt feature will come, where it will be needed to access
> > > > > DFX registers in the same area.
> > > > > 
> > > > > This approach is not scalable so intead of adding consinuously memory
> > > > > areas in the DT (and change de DT bindings, while keeping backward      
> > > > 
> > > > s/de/the/    
> > > 
> > > Oh and s/intead/instead/ too.    
> > 
> > Can you please fix the minor above and also refresh against linus master
> > branch? Patch does not apply clean anymore.  
> 
> Sure, I'll send a new version rebased on top of Linus's master branch.

Actually this series was based on v4.18-rc1. When I rebased on top of
Linus's master branch I had no conflicts to fix. I will repost a v3 but
if the problem persists you might want to share the conflicts or give
me a branch on top of which I should base this work.

Thanks,
Miqu?l
