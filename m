From: arend@broadcom.com (Arend van Spriel)
Date: Wed, 20 Apr 2011 09:57:40 +0200
Subject: Could I (ab)use bus (struct bus_type) for virtual Broadcom
 bus?
In-Reply-To: <201104200926.09110.arnd@arndb.de>
References: <BANLkTim7Uj2tsgFngWhUqFK_hk3Leg+sQA@mail.gmail.com>
	<201104191635.40351.arnd@arndb.de> <op.vt76hofg3ri7v4@arend-laptop>
	<201104200926.09110.arnd@arndb.de>
Message-ID: <op.vt7787f43ri7v4@arend-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr 2011 09:26:08 +0200, Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 20 April 2011 09:16:26 Arend van Spriel wrote:
>> >
>> > A platform device means something that cannot be probed, in every  
>> other
>> > respect it is the same as other devices. From your explanation above,
>> > it seems that you don't actually need to represent the cores on your
>> > particular chips as struct device in Linux at all.
>> >
>> > If you wanted to use platform_device, the right way would probably
>> > be an MFD device that creates multiple child devices (which end
>> > up as platform_device, though you don't need to worry about that)
>> > from the PCI driver. Then you could use the child devices completely
>> > independent from one another.
>> >
>> > Since you say that the cores in this case are tightly coupled and
>> > don't provide independent functionality to the system, there is
>> > no need to represent them as devices.
>>
>> The case is a hypothetical one, but I consider it a likely one. The axi
>> bus driver currently registers each detected core as a device in the  
>> linux
>> device tree. My statement is that this implies loose or no coupling
>> between those cores, which is not true. One (or two) exceptions have
>> already been identified. I would expect your last line to read: ...to  
>> the
>> system, those cores should not be represented as devices.
>
> The important question is what is most practical here. If most of the
> cores of this type are standalone devices, it's probably best to  
> represent
> all of them as separate devices, and find ways to deal with the few  
> logical
> devices that are spread across multiple cores.
> It it's the exception and you typically have a significant number of IP
> blocks that need to be combined to make a single logical device, I would
> recommend not representing each of them as a struct device.
>
> We really need to figure out first what the requirements are given the
> hardware you want to support with this.

Very true. I have forwarded this email conversation to a colleague of mine  
to see whether my hypothesis is likely or rarely true at least for  
Broadcom chipsets. As we concluded that Broadcom seems to be the only one  
currently using this bus that input may be sufficient to determine the  
requirements.

Gr. AvS
-- 
"The world is indeed comic, but the joke is on mankind." ? H.P. Lovecraft
