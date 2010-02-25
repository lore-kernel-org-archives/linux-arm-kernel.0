From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 25 Feb 2010 23:33:20 +0100
Subject: [PATCH] mx31pdk: Add NAND support
In-Reply-To: <933005.90402.qm@web51001.mail.re2.yahoo.com>
References: <933005.90402.qm@web51001.mail.re2.yahoo.com>
Message-ID: <1267137200.2810.10.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On gio, 2010-02-25 at 14:22 -0800, Fabio Estevam wrote:
> --- On Thu, 2/25/10, Fabio Estevam <fabioestevam@yahoo.com> wrote:
> 
> ...
> 
> > > 
> > > Are you sure that this works? Don't you see a lot of
> > Bad
> > > blocks reports
> > > in boot messages?
> > 
> > I followed the same approach used on other i.MX boards.
> > This is what I see:
> > ...
> > NAND device: Manufacturer ID: 0xec, Chip ID: 0xaa (Samsung
> > NAND 256MiB 1,8V 8-bit)         
> > Scanning device for bad blocks       
> > Bad eraseblock 42 at 0x000000540000     
> > Bad eraseblock 125 at 0x000000fa0000     
> > Bad eraseblock 887 at 0x000006ee0000     
> > Bad eraseblock 1750 at 0x00000dac0000     
> > Bad eraseblock 2046 at 0x00000ffc0000     
> > Bad eraseblock 2047 at 0x00000ffe0000     
> >                
> 
> Just looked at what Redboot reported:
> 
> ++Searching for BBT table in the flash ...                                      
> .                                                                               
> Found version 1 Bbt0 at block 2047 (0xffe0000)                                  
> Block 42 is bad                                                                 
> Block 125 is bad                                                                
> Block 887 is bad                                                                
> Block 1750 is bad                                                               
> Total bad blocks: 4   
> 
> So the only mismatch is 2046 eraseblock.
> 
> Regards,
> 
> Fabio Estevam
> 

What kernel are you running? In particular, what version
of mxc_nand.c are you building?
Recently the mxc_nand.c has been updated to support newer i.MX SoC
and the problem come after this update. (add NFC_NAND V2 support)

-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
