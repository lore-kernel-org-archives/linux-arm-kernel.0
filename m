From: me@felipebalbi.com (Felipe Balbi)
Date: Mon, 15 Mar 2010 18:10:25 +0200
Subject: [PATCH 2/2] USB: musb: omap2430: add mode change from A to B
In-Reply-To: <4B9E187E.6090802@ru.mvista.com>
References: <1268648622-28529-1-git-send-email-Hui.Wang@windriver.com>
	<1268648622-28529-2-git-send-email-Hui.Wang@windriver.com>
	<4B9E187E.6090802@ru.mvista.com>
Message-ID: <20100315161024.GC3879@gandalf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 02:22:38PM +0300, Sergei Shtylyov wrote:
>    The whole musb_platform_set_mode() seems to be implemented 
> incorrectly on OMAPs -- it shouldn't touch the DevCtl.Session bit. This 

correct. It should be changing the id pin rules just like in tusb6010.c

> function should control the ID pin override instead -- if the controller 
> supports it. SRP must be initiated thru other means, i.e. 'srp' file in 
> sysfs.

via musb_gadget_wakeup()

-- 
balbi
