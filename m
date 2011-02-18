From: drasko.draskovic@gmail.com (Drasko DRASKOVIC)
Date: Fri, 18 Feb 2011 21:56:28 +0100
Subject: Question About Linux Memory Mapping
Message-ID: <AANLkTinUoFzzx4hM8SpUt-mpjn1Z5xmrDqmXwuELuu3e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
in the article Booting ARM Linux :
http://www.simtec.co.uk/products/SWLINUX/files/booting_article.html
I can see that mem map is passed via ATAG_MEM. However, in the same
article it is mentioned that this information can also be passed via
kernel command line paramters,  mem=<size>[KM][,@<phys_offset>].

However, this does not seem to be true, as "mem" command line
parameter seems to be formated like this : mem= n[KMG] (i.e. no
offset), regarding to this reference :
http://oreilly.com/linux/excerpts/9780596100797/kernel-boot-command-line-parameter-reference.html.
Seems like memmap should be used instead.

I tried passing the parameters like memmap= n[KMG]@start[KMG] but that
had no effect at all - still the same amount of System Ram was read
from ATAGS and presented in the system via /proc/iomem.

What I needed it to reserve 1MB region for one FIFO at the end of RAM
(or somewhere else)
and protect it from the kernel. I tried passing memmap=
n[KMG]$start[KMG], but that did not worn neither.

So my questions are following :
1) Why commandlines are ignored and ATAGS are given priority ?
2) What is the most elegant way to protect one region in RAM :
 a) By giving less memory with ATAGS_MEM and thus making protected
region invisible to Linux, lying to it that RAM is smaller
 b) By changing somehow linker script
 c) By changing some configuration variables (which ?)

Thanks for the answers and best regards,
Drasko
