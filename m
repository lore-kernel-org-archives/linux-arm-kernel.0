From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 May 2014 15:21:41 +0200
Subject: [PATCHv4 3/3] ARM: mvebu: implement L2/PCIe deadlock workaround
In-Reply-To: <20140516125847.GG27822@titan.lakedaemon.net>
References: <1400165974-9059-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1400165974-9059-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140516060851.GF27822@titan.lakedaemon.net>
 <20140516090727.5264dc75@free-electrons.com>
 <20140516125847.GG27822@titan.lakedaemon.net>
Message-ID: <20140516152141.564dde70@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Fri, 16 May 2014 08:58:47 -0400, Jason Cooper wrote:

> > Hum, well, I believe it's OK, but notice that I will very likely have
> > to do a followup patch, because the solution of making all PCI I/O
> > mappings use the MT_UNCACHED memory type, suggested by Arnd, has not
> > been accepted by Will Deacon. So very likely I will have to change
> > again the mach-mvebu/coherency.c code to call a function that makes PCI
> > I/O mappings MT_UNCACHED specifically for the mach-mvebu platform. But
> > that can indeed be a followup patch.
> 
> Ahh, my mistake.  It was late.  I saw the arm,io-coherent was settled
> and mistakenly thought the other proposed changes wouldn't affect this
> patch.
> 
> I could easily drop it if you like.  It's currently the tip of mvebu/soc
> and I haven't done a signed tag for it yet.

I think it's OK, you can keep it: the PCI I/O mapping thing will come
as an addition.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
