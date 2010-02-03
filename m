From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 3 Feb 2010 20:20:01 +0100
Subject: [PATCH 12/13] ARM: LPC32XX: architecture header files
In-Reply-To: <20100203170737.GN11354@pengutronix.de>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-13-git-send-email-wellsk40@gmail.com>
	<20100203170737.GN11354@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805C8B787A9@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> > +#define VMALLOC_END	(PAGE_OFFSET + 0x10000000)
> grepping shows that defining VMALLOC_END based on PAGE_OFFSET is usual,
> but I wonder why you don't just

The maximum addressable DRAM sizing is 256MB when fully populated. It seemed
the right size. 0xF0000000 works too though, I have no problems changing it.

> 
> 	#define VMALLOC_END 0xF0000000
> 
