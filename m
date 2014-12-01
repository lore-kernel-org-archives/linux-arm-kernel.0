From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Dec 2014 22:28:39 +0100
Subject: [PATCH v3 05/11] memory: add Atmel EBI (External Bus Interface)
 driver
In-Reply-To: <20141201212820.6a7fc4b0@bbrezillon>
References: <1417429647-3419-1-git-send-email-boris.brezillon@free-electrons.com>
 <2476626.8iiXDzb2Te@wuerfel> <20141201212820.6a7fc4b0@bbrezillon>
Message-ID: <2153824.ln4mvSCK1X@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 21:28:20 Boris Brezillon wrote:
> > On Monday 01 December 2014 19:29:23 Boris Brezillon wrote:
> > > On Mon, 01 Dec 2014 17:26:27 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
> > > 
> > > #define AT91_EBICSA_REGFIELD(off)                   \
> > >     REG_FIELD(ebicsa_off, AT91_MATRIX_EBI_NUM_CS - 1)
> > > 
> > 
> > That would be acceptable too, but what I really meant is one step further:
> > 
> > static const struct reg_field at91sam9260_ebi_csa = 
> >       REG_FIELD(AT91SAM9260_MATRIX_EBICSA_OFF, 0, AT91_MATRIX_EBI_NUM_CS - 1);
> 
> That's what I did in the first place (in a version I didn't submitted),
> and I guess I'll go for that one unless you really prefer the
> alternative (I ran into a lot of trouble with DT bindings ABI
> stability, and I'd prefer to keep DT bindings as simple as
> possible).

Ok, that's good then.

	Arnd
