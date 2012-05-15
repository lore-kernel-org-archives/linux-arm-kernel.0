From: robherring2@gmail.com (Rob Herring)
Date: Tue, 15 May 2012 16:22:17 -0500
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <20120515174602.26d02f70@skate>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515165813.66b4434e@skate> <4FB2714F.5080703@codethink.co.uk>
 <201205151532.21143.arnd@arndb.de> <20120515174602.26d02f70@skate>
Message-ID: <4FB2C909.4070207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2012 10:46 AM, Thomas Petazzoni wrote:
> Le Tue, 15 May 2012 15:32:20 +0000,
> Arnd Bergmann <arnd@arndb.de> a ?crit :
> 
>>>> Agreed. When looking at the code, I wasn't sure why PCI mappings
>>>> were needed so early. Surely, the minimal mappings to get an UART
>>>> are quite useful to have very early, but why PCI?
>>>
>>> I think it was because that PCI was initialised early and requires a
>>> large mapping space. It is very likely to be legacy kernel stuff
>>> that people have kept copying through.
>>
>> No, as Rob pointed out, we might not need them early, but we
>> definitely want a fixed address for the PIO window, which ioremap
>> does not provide.
> 
> A fixed address for the PIO window of the PCI registers? Or a fixed
> address for the PIO window used to access UART registers?
> 
> I would understand why a fixed address is needed for the latter, but
> not really for the former.
> 

I'm not sure which PCI registers you mean, but we're talking about PCI
I/O space. The i/o space should be a fixed virtual address so that the
__io() is a constant base for ALL arm platforms. This isn't in place
yet, but that is the plan. Although current macros are constant base.

Rob
