From: alex@digriz.org.uk (Alexander Clouter)
Date: Wed, 9 Jun 2010 21:39:29 +0100
Subject: [PATCH] Marvell OpenRD-Ultimate machine support
In-Reply-To: <20100609203720.GK7660@chipmunk>
References: <4c0ff6b2.0c3ddf0a.2185.2e09@mx.google.com>
	<20100609203720.GK7660@chipmunk>
Message-ID: <20100609203929.GL7660@chipmunk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Alexander Clouter <alex@digriz.org.uk> [2010-06-09 21:37:20+0100]:
>
> >  	kirkwood_ge00_init(&openrd_ge00_data);
> > -	if (machine_is_openrd_client())
> > +	if (machine_is_openrd_client() ||      \__same line
> > +		machine_is_openrd_ultimate())  /
> >  		kirkwood_ge01_init(&openrd_ge01_data);
> > +  <------- REMOVE
> >  	kirkwood_sata_init(&openrd_sata_data);
> >  	kirkwood_sdio_init(&openrd_mvsdio_data);
> >  
> As that 'if()' clause is still less than 77 chars wide:
> ----
> kirkwood_ge00_init(&openrd_ge00_data);
> if (machine_is_openrd_client() || machine_is_openrd_ultimate())
> 	kirkwood_ge01_init(&openrd_ge01_data);
> kirkwood_sata_init(&openrd_sata_data);
> kirkwood_sdio_init(&openrd_mvsdio_data);
> ----
> 
Better still, just make this 'if(!machine_is_openrd_base())'.

Cheers

-- 
Alexander Clouter
.sigmonster says: What this country needs is a good five cent microcomputer.
