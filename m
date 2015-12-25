From: eric@anholt.net (Eric Anholt)
Date: Thu, 24 Dec 2015 16:01:40 -0800
Subject: [PATCH v2 0/8] Raspberry Pi 2 support.
In-Reply-To: <201512222223.52449.arnd@arndb.de>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
 <201512220011.32234.arnd@arndb.de> <20151222142045.GA29335@omega>
 <201512222223.52449.arnd@arndb.de>
Message-ID: <87lh8jqtuj.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Tuesday 22 December 2015, Alexander Aring wrote:
>> Later while booting the kernel hangs forever, the solution on my side
>> was to enable:
>> 
>> CONFIG_HAVE_ARM_ARCH_TIMER
>> 
>> I think this doesn't use the BCM2835 timer anymore and some cortex-a7
>> related "generic timer", or?
>
> Right, but I don't see how that relates to the irqchip. Is the BCM2835 timer
> connected to a secondary irqchip, while the arch timer connects to the primary GIC?

The 2835 timer is a "peripheral", and connects to the second level
irqchip, while the arm arch timer can give us per-cpu interrupts in the
first level controller.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151224/f28d54c2/attachment.sig>
