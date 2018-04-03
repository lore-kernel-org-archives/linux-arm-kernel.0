From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 3 Apr 2018 09:32:29 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <20180403091522.1a498544@bbrezillon>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon>
 <20180402222020.1d344c14@bbrezillon>
 <d9da5ae4-68d0-df88-1214-f53f6b18d718@axentia.se>
 <20180403091522.1a498544@bbrezillon>
Message-ID: <20180403093229.66dd1dcf@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Apr 2018 09:15:22 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
> > 
> > to
> > 
> >  0 33--3--3--3333--
> >  1 33--3--3--3333--
> >  2 33--------------
> >  3 -3--------333---
> >  4 33--------------
> >  5 3---------------
> >  6 33--33-33333333-
> >  7 --1-1--3--------
> >  8 -1---1--3--3----  
> 
> Why do you change priority on slave 7 and 8 (AKA DDR port 0 and 1)?
> They don't seem to be used by the LCDC.
> 
> >  9 --1-1--3-33-333-  
> 
> Shouldn't we have
> 
>    9 -1---1--3--1----
> 
> here?

Never mind. I just read the email where you explain the datasheet vs
reality mismatch after this one.

I guess we'll have to wait for a Nicolas' feedback here.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
