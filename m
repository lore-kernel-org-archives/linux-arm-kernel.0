From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 22 May 2013 17:56:31 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <201305221743.47679.arnd@arndb.de>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221718.53759.arnd@arndb.de> <519CE651.6070209@free-electrons.com>
 <201305221743.47679.arnd@arndb.de>
Message-ID: <519CEAAF.2050600@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2013 05:43 PM, Arnd Bergmann wrote:
> On Wednesday 22 May 2013, Gregory CLEMENT wrote:
>> Loosing the earlyprintk would be a big regression. Having DEBUG_LL disabled
>> in multiplatform case is fine.
> 
> EARLY_PRINTK depends on DEBUG_LL, so that makes no sense.
> 
>> If the kernel seems to not run at all we
>> can still build a kernel for only for mvebu, activate earlyprintk and see
>> what happened. With your proposal we won't have any more this feature, and
>> it will make the debug or the bug report for the user much harder. As we still
>> in active development I really want to avoid it.
> 
> I don't understand. You should still be able to turn on DEBUG_LL when you need
> it. It will just work only on the machines it is configured for, as it always
> does. You will need a separate Kconfig option for each physical address though,
> but that is also nothing new.

But you proposed to use device tree instead of CP15. In this case we won't be
able to use earlyprintk that was my point. You justified the fact to not use
earlyprintk because we can't use it for multiplatform. So I am fine to not being
able to use earlyprintk in multiplatform, but it sill important to be able to
continue to use in non multiplatform case, hence the need of the use of CP15
bit.



> 
> 	Arnd
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
