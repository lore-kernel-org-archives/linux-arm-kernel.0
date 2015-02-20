From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 20 Feb 2015 10:48:18 -0800
Subject: [PATCH 2/4] of: DT quirks infrastructure
In-Reply-To: <54E77876.9020500@hurleysoftware.com>
References: <FE61DD1C-51DA-4869-8A62-C019C3D70577@konsulko.com>
 <20150218173115.GG29429@leverpostej>
 <76BD1B22-BAED-4205-9B34-186907CE0217@konsulko.com>
 <54E613E7.2020405@gmail.com>
 <670D0881-DBF0-45E8-A502-A6DB2B77A750@konsulko.com>
 <54E61DD2.3060002@gmail.com>
 <53F2F94C-0C43-4A54-B8CD-EEC454A0AC19@konsulko.com>
 <54E742F2.80506@hurleysoftware.com>
 <20150220164753.GC22752@roeck-us.net>
 <54E77876.9020500@hurleysoftware.com>
Message-ID: <20150220184818.GC26698@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 01:09:58PM -0500, Peter Hurley wrote:
> Hi Guenter,
> 
> On 02/20/2015 11:47 AM, Guenter Roeck wrote:
> 
> [...]
> 
> > I am open to hearing your suggestions for our use case, where the CPU card with
> > the eeprom is manufactured separately from its carier cards.
> 
> I think your use case may be more compelling than two flavors of Beaglebone
> (one of which is pretty much a dead stick), but it's also less clear what your
> design constraints are (not that I really want to know, 'cause I don't).
> 
> But the logical extension of this is an N-way dtb that supports unrelated SOCs,
> and I think most would agree that's not an acceptable outcome.
> 
With this logic you can pretty much refuse to accept anything new, anywhere.
Including everything old, for that matter.

Food can be abused to poison people, therefore no one should be permitted to
distribute food. Houses can be abused to falsely imprison people, therefore
no one should live in houses. And don't even start talking about guns.
Everything can be abused, therefore we should not do anything.

Discussions about possible abuse are for sure valid, and reducing the potential
for abuse is a worthy goal, but not as argument to reject a solution for an
existing and real roblem outright.

> My thought was that every design that can afford an EEPROM to probe can afford
> a bootloader to select the appropriate dtb, and can afford the extra space
> required for multiple dtbs.
> 
There are many more use cases where this is simply not the case. Another one,
for example, is a system where the devicetree is loaded through u-boot using
tftp. In this case, u-boot would have some information about the hardware
to request the correct devicetree file, but it may not know about hardware
variants.

Sure, one could solve that problem by making u-boot aware of such variants
and maintaining a large number of dtb files as you suggest. That means,
however, that there would be that need to maintain all those dtb files
just to address minor differences, and having modify every piece of the
system for each new variant. In essence you put a lot of burden on pretty
much everyone from software to manufacturing to testing, plus possibly
hardware, just for the purpose of rejecting a relatively simple solution
for the problem Pantelis' patch set is trying to address.

Ultimately, no matter what the kernel community ends up doing, Pantelis'
solution or something similar _will_ find its way into our system.
I would very much prefer to have the code upstream, but we will carry
his patches along in our vendor branch if necessary. The functionality
and its benefits for our development, manufacturing, and testing process
are way too valuable to ignore, and it actually solves problems for which
we don't have an acceptable solution today. I would be quite surprised
if other vendors would not end up doing the same.

Guenter
