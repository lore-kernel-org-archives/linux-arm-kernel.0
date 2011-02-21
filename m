From: henryzhang62@yahoo.com (hong zhang)
Date: Sun, 20 Feb 2011 21:27:57 -0800 (PST)
Subject: Question About Linux Memory Mapping
In-Reply-To: <201102192122.53746.marek.vasut@gmail.com>
Message-ID: <919555.44803.qm@web161702.mail.bf1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drasko,

Command line can assign all physical memory or partial memory to kernel using one or few mem=. For example, if you have 1 GBytes memory with starting port at 0x80000000, and want to reserve 512M anywhere between 0x80000000 and 0xc0000000 saying at 0x90000000. Then command line should be
mem=256M at 0x80000000 mem=256M at 0xb0000000. At this format, kernel should not touch memory between 0x9000000 and 0xb0000000 and the memory can be used by other OS or firmware.

This is my understanding.

---henry

--- On Sat, 2/19/11, Marek Vasut <marek.vasut@gmail.com> wrote:

> From: Marek Vasut <marek.vasut@gmail.com>
> Subject: Re: Question About Linux Memory Mapping
> To: linux-arm at lists.infradead.org
> Cc: "Drasko DRASKOVIC" <drasko.draskovic@gmail.com>, linux-arm-kernel at lists.infradead.org
> Date: Saturday, February 19, 2011, 2:22 PM
> On Friday 18 February 2011 21:56:28
> Drasko DRASKOVIC wrote:
> > Hi all,
> > in the article Booting ARM Linux :
> > http://www.simtec.co.uk/products/SWLINUX/files/booting_article.html
> > I can see that mem map is passed via ATAG_MEM.
> However, in the same
> > article it is mentioned that this information can also
> be passed via
> > kernel command line paramters,?
> mem=<size>[KM][,@<phys_offset>].
> > 
> > However, this does not seem to be true, as "mem"
> command line
> > parameter seems to be formated like this : mem= n[KMG]
> (i.e. no
> > offset), regarding to this reference :
> > http://oreilly.com/linux/excerpts/9780596100797/kernel-boot-command-line-pa
> > rameter-reference.html. Seems like memmap should be
> used instead.
> > 
> > I tried passing the parameters like memmap=
> n[KMG]@start[KMG] but that
> > had no effect at all - still the same amount of System
> Ram was read
> > from ATAGS and presented in the system via
> /proc/iomem.
> > 
> > What I needed it to reserve 1MB region for one FIFO at
> the end of RAM
> > (or somewhere else)
> > and protect it from the kernel. I tried passing
> memmap=
> > n[KMG]$start[KMG], but that did not worn neither.
> 
> What are you exactly trying to achieve ? btw. if you really
> need to make a hole 
> in RAM, you should reserve a bootmem node maybe?
> > 
> > So my questions are following :
> > 1) Why commandlines are ignored and ATAGS are given
> priority ?
> > 2) What is the most elegant way to protect one region
> in RAM :
> >? a) By giving less memory with ATAGS_MEM and thus
> making protected
> > region invisible to Linux, lying to it that RAM is
> smaller
> >? b) By changing somehow linker script
> >? c) By changing some configuration variables
> (which ?)
> > 
> > Thanks for the answers and best regards,
> > Drasko
> > 
> > _______________________________________________
> > linux-arm mailing list
> > linux-arm at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm
> 
> _______________________________________________
> linux-arm mailing list
> linux-arm at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm
> 


      
