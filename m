From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 16 Oct 2010 12:43:42 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <1287196789.2370.3.camel@pasglop>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<20101009000046.GA30616@kroah.com>
	<1287196789.2370.3.camel@pasglop>
Message-ID: <AANLkTi=a4XOfOZ=cPey5eK2DXUY3eXo=b-rOUVKz1n2C@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/16 Benjamin Herrenschmidt <benh@kernel.crashing.org>:
> On Fri, 2010-10-08 at 17:00 -0700, Greg KH wrote:
>>
>> But you can't expect that you make this change, and not fix up the
>> drivers, and people would be happy, right? ?The rule for API changes
>> like this, or anything, is that the person making the change fixes the
>> other drivers, and that seems to be the issue here.
>>
>> Any pointers to patches where people have fixed up the drivers?
>
> Greg, this is true for normal API changes. In this case, this is silent
> data corruption, I think Russell is absolutely right. That exact same
> issues have been giving me nightmares on powerpc, mostly due to
> (fortunately extremely rare) broken chipsets doing non coherent DMA on
> processors that do not allow you architecturally to double map memory
> with different attributes.

Yes, but the kernel could have a mechanism, like the constant memory
allocator so that people can configure a certain amount of RAM, like
CONFIG_CMA_RESERVE_SIZE, and then drivers could request blocks from
there which are not mapped as kernel memory. The constant memory
allocator could map them at the same time they are requested by
drivers with different attributes.

-- 
Felipe Contreras
