From: hemantp@ti.com (Pedanekar, Hemant)
Date: Sun, 10 Oct 2010 19:53:51 +0530
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <20101009164517.GA28183@n2100.arm.linux.org.uk>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101009135210.GA25564@n2100.arm.linux.org.uk>
	<AANLkTi=Sv35ipSGzSoJMjdoNU-Qee9csviPL3yMSM3uf@mail.gmail.com>
	<20101009164517.GA28183@n2100.arm.linux.org.uk>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0356711C7F@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote on Saturday, October 09, 2010 10:15 PM:

> On Sat, Oct 09, 2010 at 07:07:01PM +0300, Felipe Contreras wrote:
>> On Sat, Oct 9, 2010 at 4:52 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Thu, Oct 07, 2010 at 12:44:22PM +0300, Felipe Contreras wrote:
>>>> For issues related to this:
>>>> http://article.gmane.org/gmane.linux.ports.arm.kernel/84454
>>> 
>>> This one nicely shows some of the problems which can occur with the
>>> memory type attributes - and this is not attributable to ioremap().
>>> 
>>> ioremap() is used to map devices. ?It creates device memory type mappings.
>>> If what you're mapping doesn't support device memory type mappings, then
>>> accesses via an ioremap()'d region isn't going to work - as this guy is
>>> observing. 
>>> 
>>> That's not because ioremap() is doing something wrong. It's doing what
>>> it's meant to do. ?The use is wrong, and is completely unrelated to the
>>> issue you've raised.
>> 
>> Ok, I was confused by Catalin's comment which does point to ioremap() on
>> normal RAM: http://article.gmane.org/gmane.linux.ports.arm.kernel/84504
> 
> Me too - it doesn't appear to relate to the specified problem.  You
> don't want to map RAM as device nor strongly ordered, and we still
> don't know what this "MMR" is.
> 

Just to add, the issue I faced was a different issue and more to do with
specific access requirement for particular memory mapped region and what memory
types could be used for defining mappings of the region (or passed as ioremap
parameter). To summarize, I needed to use type=MT_STRONGLY_ORDERED to make access
to the peripheral registers work, which, unfortunately is not available in the
kernel.

(BTW, I had referred MMR as memory mapped registers of the concerned peripheral.)

-
Hemant
