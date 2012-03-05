From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 5 Mar 2012 20:13:26 +0000
Subject: [PATCH v3 02/30] ARM: provide runtime hook for ioremap/iounmap
In-Reply-To: <alpine.LFD.2.02.1203051415150.31242@xanadu.home>
References: <1330658022-14559-1-git-send-email-robherring2@gmail.com>
 <1330658022-14559-3-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1203051415150.31242@xanadu.home>
Message-ID: <201203052013.26688.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 05 March 2012, Nicolas Pitre wrote:
> Given that the majority of existing platforms don't need the 
> indirection, should we make this indirection conditional on 
> CONFIG_NEED_IOREMAP_HOOK and let those who need it select it?  Or maybe 
> this isn't performance critical and we just don't care?  In any case I'd 
> like to see such reasoning captured in the commit log.

It's certainly not performance critical, but there may be some space overhead
in the .text section of the kernel that we could avoid by adding another
indirection.

	Arnd
