From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Thu, 25 Feb 2010 14:22:39 -0800 (PST)
Subject: [PATCH] mx31pdk: Add NAND support
Message-ID: <933005.90402.qm@web51001.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


--- On Thu, 2/25/10, Fabio Estevam <fabioestevam@yahoo.com> wrote:

...

> > 
> > Are you sure that this works? Don't you see a lot of
> Bad
> > blocks reports
> > in boot messages?
> 
> I followed the same approach used on other i.MX boards.
> This is what I see:
> ...
> NAND device: Manufacturer ID: 0xec, Chip ID: 0xaa (Samsung
> NAND 256MiB 1,8V 8-bit)? ? ? ? ?
> Scanning device for bad blocks? ? ? ?
> Bad eraseblock 42 at 0x000000540000? ? ?
> Bad eraseblock 125 at 0x000000fa0000? ? ?
> Bad eraseblock 887 at 0x000006ee0000? ? ?
> Bad eraseblock 1750 at 0x00000dac0000? ? ?
> Bad eraseblock 2046 at 0x00000ffc0000? ? ?
> Bad eraseblock 2047 at 0x00000ffe0000? ? ?
> ? ? ? ? ? ? ? ?

Just looked at what Redboot reported:

++Searching for BBT table in the flash ...                                      
.                                                                               
Found version 1 Bbt0 at block 2047 (0xffe0000)                                  
Block 42 is bad                                                                 
Block 125 is bad                                                                
Block 887 is bad                                                                
Block 1750 is bad                                                               
Total bad blocks: 4   

So the only mismatch is 2046 eraseblock.

Regards,

Fabio Estevam


      
