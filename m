From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 3 Jan 2018 21:52:06 +0100
Subject: [PATCH 00/12] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <20180103211028.619cd16d@bbrezillon>
References: <20171207201814.30411-1-miquel.raynal@free-electrons.com>
 <20171214070930.0b885f6d@bbrezillon>
 <877etkecig.fsf@belgarion.home> <20171218092535.2ca1fe13@xps13>
 <87y3lxccr7.fsf@belgarion.home>
 <20171220224121.2cb6f690@bbrezillon>
 <87lghucykr.fsf@belgarion.home>
 <20171222222441.0fd77df9@bbrezillon>
 <20171222233730.68d9cb9d@xps13> <87k1xdblxf.fsf@belgarion.home>
 <20171223155709.2ba16e95@xps13> <87fu81bc45.fsf@belgarion.home>
 <20180102120326.7a2cf1d1@xps13> <87d12scbiy.fsf@belgarion.home>
 <20180103084037.422b239a@xps13> <878tded89m.fsf@belgarion.home>
 <20180103211028.619cd16d@bbrezillon>
Message-ID: <20180103215206.5d85b41b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 3 Jan 2018 21:10:28 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> On Wed, 03 Jan 2018 20:58:29 +0100
> Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> 
> > Miquel RAYNAL <miquel.raynal@free-electrons.com> writes:
> >   
> > > On Tue, 02 Jan 2018 20:21:09 +0100
> > > Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> > >    
> > >> Miquel RAYNAL <miquel.raynal@free-electrons.com> writes:
> > >>     
> > >> > I think the ECC issue you faced was related to pages being written
> > >> > *and* empty. If this guess is right, the board should boot fine with
> > >> > these changes.
> > >> >
> > >> > Otherwise, please add the DEBUG define as before in both the core
> > >> > and the driver and do not hesitate to add another dump_stack()
> > >> > where it crashes (if applicable).      
> > >> 
> > >> The problem looks still the same :
> > >> [    3.560163] Bad block table not found for chip 0    
> > >
> > > Mmmmh ok.
> > >
> > > Can you please add this patch:
> > > http://code.bulix.org/61at9p-254626    
> > 
> > Well, it looks a bit better, see attached log in [1].
> > Now the BBT is detected ...
> > [    3.310841] Bad block table found at page 131008, version 0x01
> > ...
> > [    3.354944] Bad block table found at page 130944, version 0x01
> > 
> > But all blocks are considered bad ... as if the bit logic was inverted for the
> > meaning of "bad" or "good" block, see :
> > [    3.379825] nand_read_bbt: bad block at 0x000000000000  
> 
> Hm, that's weird. Can you try with the old driver (pxa3xx)?

Alternatively, you can type 'nand bad' from uboot to check if it
detects the same bad blocks.
