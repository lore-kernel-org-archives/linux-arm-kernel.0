From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 16 Feb 2017 23:25:29 +0100
Subject: [PATCHv3 2/2] arch: Rename CONFIG_DEBUG_RODATA and
 CONFIG_DEBUG_MODULE_RONX
In-Reply-To: <1486427518-14819-3-git-send-email-labbott@redhat.com>
References: <1486427518-14819-1-git-send-email-labbott@redhat.com>
 <1486427518-14819-3-git-send-email-labbott@redhat.com>
Message-ID: <20170216222529.GA7531@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

>  
> -config DEBUG_RODATA
> +config STRICT_KERNEL_RWX
>  	bool "Make kernel text and rodata read-only" if ARCH_OPTIONAL_KERNEL_RWX
>  	depends on ARCH_HAS_STRICT_KERNEL_RWX
>  	default !ARCH_OPTIONAL_KERNEL_RWX ||

Debug features are expected to have runtime cost, so kconfig help is
silent about those. But there are runtime costs, right? It would be
nice to mention them in the help text...

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170216/48ce1aeb/attachment.sig>
