From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Oct 2010 11:52:16 +0100
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <AANLkTinMuKDpbL9ka61QhUFJfze_HWWHxjUbAqbz2_vi@mail.gmail.com>
References: <20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<20101009000046.GA30616@kroah.com>
	<20101009002546.GB14675@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010082210150.3107@xanadu.home>
	<1286791544.19739.31.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinMuKDpbL9ka61QhUFJfze_HWWHxjUbAqbz2_vi@mail.gmail.com>
Message-ID: <20101011105216.GD27153@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 01:39:13PM +0300, Felipe Contreras wrote:
> Anyway, I'm reading the TRM and I can't find any mention of this.
> Catalin, can you point out where is this mentioned, and also, can you
> confirm if this would affect only the memory that has the double
> mapping, or it can corrupt other memory as well?

Page A3-31:

  If the same memory locations are marked as having different cacheability
  attributes, for example by the use of aliases in a virtual to physical
  address mapping, behavior is UNPREDICTABLE.

Page A3-36:

  Behavior is UNPREDICTABLE if the same memory location:
   ? is marked as Shareable Normal and Non-shareable Normal
   ? is marked as having different memory types (Normal, Device, or Strongly-
     ordered)
   ? is marked as having different cacheability attributes
   ? is marked as being Shareable Device and Non-shareable Device memory.

  Such memory marking contradictions can occur, for example, by the use of
  aliases in a virtual to physical address mapping.

And from the glossary:

  UNPREDICTABLE Means the behavior cannot be relied upon. UNPREDICTABLE
  behavior must not represent security holes. UNPREDICTABLE behavior must
  not halt or hang the processor, or any parts of the system. UNPREDICTABLE
  behavior must not be documented or promoted as having a defined effect.
