From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sat, 9 Oct 2010 03:56:23 +0300
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101008234448.GD10975@n2100.arm.linux.org.uk>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinhwORqdWU43yr1AXJGZm2zPKGG+Q9twruNs2aH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/9 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Oct 08, 2010 at 04:25:39PM -0700, Greg KH wrote:
>> Also, how can we fix this in a driver, what is the proper steps to do
>> so?
>
> On April 23rd:
> | I think a viable safe solution is to set aside some RAM at boot (which
> | the kernel doesn't manage at all) and then use ioremap on that; that
> | approach will still work with this patch in place.
>
> On April 30th when discussing the omapfb driver:
> | There's really one option for this - in the machine's fixup handler, you
> | can walk the meminfo array and kick out some memory from that. ?This will
> | prevent the kernel mapping that memory and make pfn_valid() fail for that
> | memory range. ?Another advantage of this is that it won't break when we
> | switch to LMB.

These are not solutions, these are pointers to find the solutions.

How do you set aside some RAM at boot for that? Is there anything like
memblock to do that? Or do you expect to set aside some memory with
mem=X, and manually specify the address in the .config?

> Unfortunately, what I fear is that nothing will happen because people
> want the ioremap-on-system-RAM to just work, and then we'll hit this
> exact same issue again in three months time.

Nobody has ever said, or suggested anything like that.

What people want is:
1) A solution in place
2) Time to implement that solution in their drivers

And since you did, let me say what I fear: that many more people will
find drivers totally broken on 2.6.36.

-- 
Felipe Contreras
