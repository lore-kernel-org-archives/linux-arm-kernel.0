From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 14:20:31 +0100
Subject: -next build failures in k3dma.c
In-Reply-To: <20150113120751.GQ4160@sirena.org.uk>
References: <E1YAwSG-0000zm-Cs@debutante> <20150113120751.GQ4160@sirena.org.uk>
Message-ID: <2546132.YsPQSK8ktD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 January 2015 12:07:51 Mark Brown wrote:
> On Tue, Jan 13, 2015 at 08:04:00AM +0000, Build bot for Mark Brown wrote:
> 
> > 	arm-allmodconfig
> > ../drivers/dma/k3dma.c:823:12: error: conflicting types for 'k3_dma_resume'
> 
> For several days now k3dma.c has been failing to build in an ARM
> allmodconfig because the definition of k3_dma_resume() introduced in
> db08425ebd51f (dmaengine: k3: Split device_control) taking a struct
> dma_chan * conflicts with that which has been in the file since it was
> originally merged taking a struct device *.

Incidentally, I've restarted by randconfig build testing today, will follow
up with my fix.

	Arnd
