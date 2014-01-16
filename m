From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Jan 2014 11:47:12 +0100
Subject: [PATCH v3 2/2] serial: fsl_lpuart: add DMA support
In-Reply-To: <4a519c52821b4ceb841cbefcf2a0432b@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1389763265-27300-2-git-send-email-yao.yuan@freescale.com>
 <201401151025.34628.arnd@arndb.de>
 <4a519c52821b4ceb841cbefcf2a0432b@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <201401161147.13522.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 January 2014, Yao Yuan wrote:
> > This part will result in a slight increase in data size even if dma
> > support is turned off at compile time.
> > 
> 
> Yes, someone also want me define a independent struct for dma and allocate the memory when dma be use.
> But I think this way will add a more memory access time, like a->b->c and a->c. And the variable 
> about dma is just a few bytes but used frequently. So I think I'd better define the variable about dma in lpuart_port struct.

I agree. Just leave it unconditionally in here to make the code simpler.

	Arnd
