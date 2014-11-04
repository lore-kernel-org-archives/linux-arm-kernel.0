From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 04 Nov 2014 14:15:32 +0100
Subject: [PATCH v8 5/9] ARM: irqchip: mxs: add Alpascale ASM9260 support
In-Reply-To: <20141104131349.GF4042@n2100.arm.linux.org.uk>
References: <1413888020-8790-1-git-send-email-linux@rempel-privat.de>
 <1413888020-8790-6-git-send-email-linux@rempel-privat.de>
 <20141104130320.GB21210@tiger> <20141104131349.GF4042@n2100.arm.linux.org.uk>
Message-ID: <5458D174.9080202@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 04.11.2014 um 14:13 schrieb Russell King - ARM Linux:
> On Tue, Nov 04, 2014 at 09:03:23PM +0800, Shawn Guo wrote:
>> Thanks Jason for pointing me the thread.
>>
>> On Tue, Oct 21, 2014 at 12:40:16PM +0200, Oleksij Rempel wrote:
>>> +config IRQ_MXS
>>> +	bool "MXS interrupt controller"
>>> +	select IRQ_DOMAIN
>>> +	select STMP_DEVICE
>>> +	default y if MACH_ASM9260 || CONFIG_ARCH_MXS
>>
>> s/CONFIG_ARCH_MXS/ARCH_MXS
>>
>> Even with this change, the 'default y' doesn't seem to work for me.
> 
> The only way an option follows its default is if it doesn't have a visible
> prompt.  So:
> 
> config IRQ_MXS
> 	def_bool y if MACH_ASM9260 || ARCH_MXS
> 	select IRQ_DOMAIN
> 	select STMP_DEVICE
> 
> will cause it to always be defined to 'y' if either of those options are
> enabled.  Otherwise, if it has a visible prompt, it follows (in order of
> precedence) whatever the user specifies, the configuration file, or the
> Kconfig specified default, or 'n'.  (Each limited by selects and
> dependencies.)

Ok, will fix it.

> Is there a particular reason why the option is being offered for user
> selection?

no.

-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141104/39bc5dd9/attachment.sig>
