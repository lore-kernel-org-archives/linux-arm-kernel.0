From: ahs3@redhat.com (Al Stone)
Date: Tue, 26 Apr 2016 10:02:30 -0600
Subject: [RFC] Is /dev/port useful on arm64?
In-Reply-To: <4771157.GTXbP8MYg9@wuerfel>
References: <571E9B98.4050505@redhat.com> <4771157.GTXbP8MYg9@wuerfel>
Message-ID: <571F9116.7050000@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2016 04:43 PM, Arnd Bergmann wrote:
> On Monday 25 April 2016 16:35:04 Al Stone wrote:
>>
>> However, /dev/port is used for both ISA and PCI IO ports.  So, this led me
>> to what may be a dumb question: is there really a need for PCI support in
>> /dev/port for arm64?
>>
>> Supporting ISA just seems silly, at least from an ARMv8 server standpoint,
>> but PCI is less clear to me.  Anyone have opinions one way or the other?
> 
> Hisilicon has an ISA-like bus in their system, in form of LPC.

Right, I'd heard about that one.

>> It seems like it would be a waste of time to do the work to make sure the
>> PCI ports work correctly only to find out they will never be used, but I
>> can't think of anyone that actually needs them.
> 
> I think we should change the /dev/port implementation to interact with
> the architecture code so it knows which addresses have been registered
> through pci_ioremap_io to ensure that accessing it at least doesn't
> predictably crash the kernel.

Yeah, agreed, but a more long term solution than I personally need today.
I'll look into it a bit more, though.

> Aside from that, most distros probably want to disable it anyway along
> with /dev/mem, but an embedded user can access the two if they absolutely
> need to.
> 
> 	Arnd

This is what I was thinking, too, but I didn't want to cut anything
short if someone was actually using it.


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3 at redhat.com
-----------------------------------
