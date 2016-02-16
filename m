From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 16:08:34 +0100
Subject: [PATCH v3 08/10] ARM: configs: add MPS2 defconfig
In-Reply-To: <56C3378F.2010008@arm.com>
References: <1455617295-23736-1-git-send-email-vladimir.murzin@arm.com>
 <2680417.bULLX3O66Y@wuerfel> <56C3378F.2010008@arm.com>
Message-ID: <11778979.HbWgmZUCnF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 14:51:59 Vladimir Murzin wrote:
> > 
> > Why CONFIG_EMBEDDED? You probably mean CONFIG_EXPERT, but then what do
> > you need that for?
> 
> TBH, I have no special requirement for this option to be set and now,
> looking at Kconfig entry for this option, I think that I got it here
> because I stated configuration with allnoconfig.
> 
> OTOH, I don't see how harmful it can be since description says:
> 
>           This option should be enabled if compiling the kernel for
>           an embedded system so certain expert options are available
>           for configuration
> 
> yes, it selects CONFIG_EXPERT and that had side effect that, for
> example, CONFIG_NAMESPACE could be compiled out.
> 
> Have I missed something around it?

Just the history behind this symbol. We removed it a while ago in
favor if CONFIG_EXPERT, assuming that it makes it clearer that it's
not just for embedded systems, or for systems with small memory.

It's  basically a zombie symbol that nobody should use directly
(independent of what the documentation says...).

	Arnd
