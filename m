From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 5 May 2011 10:51:38 +0200
Subject: PXA270 DIMM Module (NOR Flash) on v2.6.38
In-Reply-To: <BANLkTikw1YHa8SPzhz51B7QCwZWNbJ=gAA@mail.gmail.com>
References: <BANLkTin7EZb0src6sOA11yre-EQm+8cnVw@mail.gmail.com>
	<201105041731.02206.marek.vasut@gmail.com>
	<BANLkTikw1YHa8SPzhz51B7QCwZWNbJ=gAA@mail.gmail.com>
Message-ID: <201105051051.39086.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 05, 2011 09:54:57 AM Bas van Tiel wrote:
> Hi Marek,
> 
> I tried your config on a stock v2.6.38. The resulting image is written to
> eeprom at 0x80000 address and I started via bootm 0x80000.
> Decompressing is ok but then it hangs again, the cpu is still in IRQ-mode
> at the same address 0xffff0018 :-(..

CCing linux arm kernel.

Try one more thing ... check if the kernel with my config forces command line and 
if so, check if there's a mem= option. If it's missing, add mem=128M at 0xa0000000, 
for some reason, I recently had issues with passing kernel params from 
bootloader.

I also had issues with 256MB module, dunno if it's your case. FTTB, use only 
128MB until it's solved. It's work in progress.

> 
> greetings
> Bas
> 
> 
> 2011/5/4 Marek Vasut <marek.vasut@gmail.com>
> 
> > On Wednesday, May 04, 2011 02:55:59 PM Bas van Tiel wrote:
> > > Hi Marek,
> > > 
> > > currently I'm running the latest u-boot from the git archive on the
> > 
> > vpac270
> > 
> > > module, no problems so far. The latest kernel
> > > is giving me problems when I load it via u-boot. The uncompression goes
> > > well but somewhere in the boot proces it hangs. The
> > > debugger shows that the ARM is in IRQ mode and the PC is at 0xffff0018,
> > > executing a 0xea0000 instruction. Somehow it looks
> > > like the vector table is not initialized.
> > 
> > I met this too.
> > 
> > > In the Voipac directory I don't see any patches so I assume that the
> > > vanilla kernel is good enough. I also disabled in the board
> > 
> > initialization
> > 
> > > all the pheriperal initialization
> > > except for the serial port but no luck so far. Do you have any
> > 
> > suggestions
> > 
> > > for me to look for?
> > 
> > Try attached config, I already discussed this with voipac people, they
> > met the
> > same issue.
> > 
> > > greetings
> > > Bas
