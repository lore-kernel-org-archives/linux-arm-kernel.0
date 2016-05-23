From: sf84@laposte.net (Sebastian Frias)
Date: Mon, 23 May 2016 15:22:27 +0200
Subject: [U-Boot] Sharing code between Linux and bootloader (U-boot) ?
In-Reply-To: <20160521014159.GK7650@bill-the-cat>
References: <573F1F07.6040202@laposte.net> <20160521014159.GK7650@bill-the-cat>
Message-ID: <57430413.2020704@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tom,

On 05/21/2016 03:41 AM, Tom Rini wrote:
> On Fri, May 20, 2016 at 04:28:23PM +0200, Sebastian Frias wrote:
> 
>> Hi,
>>
>> Some bootloaders (like U-boot) support several HW devices: serial,
>> network, NAND, USB, etc. most of which are also supported by Linux.
>>
>> So the question is: is code shared? I mean, I understand that the
>> drivers need to talk to the appropriate API, and such API could be
>> different between Linux and U-boot.
>> But putting that aside, would it be naive to imagine that some "core"
>> functionality could be shared? Or would that part be so small it is
>> not worth the effort?
>>
>> Since many companies use both, U-boot and Linux, I would figure they
>> try their best to optimize engineering resources and share code,
>> right?
>> In that case, I also wonder how do they share DT descriptions that
>> right now are being stored in the Linux kernel tree.
>>
>> We'd like to share code/DT for obvious reasons, what would you guys
>> suggest?
> 
> So, in all cases, Linux is always the primary.  

For drivers and DT?

>In some cases in U-Boot
> we port drivers over (NAND is a good example here). 

>From your message, I get that first you write the driver for Linux and then port to U-boot, is that right?
I would have thought that the opposite way could be easier, since the U-boot driver could be simpler (maybe no DMA) w.r.t the one in Linux.

> In other cases,
> things are similar enough that it's having done it in one place it's
> easy enough to do it again in the other.
> 

So, basically people just do it again, duplicating code?

Best regards,

Sebastian
