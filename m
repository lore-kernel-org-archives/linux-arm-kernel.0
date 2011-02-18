From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 18 Feb 2011 17:04:09 -0500 (EST)
Subject: Question About Linux Memory Mapping
In-Reply-To: <AANLkTinUoFzzx4hM8SpUt-mpjn1Z5xmrDqmXwuELuu3e@mail.gmail.com>
References: <AANLkTinUoFzzx4hM8SpUt-mpjn1Z5xmrDqmXwuELuu3e@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1102181645350.14920@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Feb 2011, Drasko DRASKOVIC wrote:

> Hi all,
> in the article Booting ARM Linux :
> http://www.simtec.co.uk/products/SWLINUX/files/booting_article.html
> I can see that mem map is passed via ATAG_MEM. However, in the same
> article it is mentioned that this information can also be passed via
> kernel command line paramters,  mem=<size>[KM][,@<phys_offset>].
> 
> However, this does not seem to be true, as "mem" command line
> parameter seems to be formated like this : mem= n[KMG] (i.e. no
> offset), regarding to this reference :
> http://oreilly.com/linux/excerpts/9780596100797/kernel-boot-command-line-parameter-reference.html.
> Seems like memmap should be used instead.

I invite you to have a look at the code in arch/arm/kernel/setup.c 
especially the line that reads as:

early_param("mem", early_mem);

and also the function just above it.

Remember that the code is always the ultimate documentation.
It is open, you have it, so use it !

> So my questions are following :
> 1) Why commandlines are ignored and ATAGS are given priority ?

Probably because your command line didn't make it through to the kernel.

> 2) What is the most elegant way to protect one region in RAM :
>  a) By giving less memory with ATAGS_MEM and thus making protected
> region invisible to Linux, lying to it that RAM is smaller

That's the most common method at the moment.

>  b) By changing somehow linker script

The linker script has no impact on the available RAM.  This is not a 
deep embedded environment.

>  c) By changing some configuration variables (which ?)

That is also possible along with the kernel cmdline, and the answer is 
also in that arch/arm/kernel/setup.c source file.

Good luck!


Nicolas
