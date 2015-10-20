From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 20 Oct 2015 17:10:52 +0200
Subject: [PATCH 0/5] drivers/tty: make more bool drivers explicitly
 non-modular
In-Reply-To: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20151020151052.GI3421@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/10/2015 at 18:21:13 -0400, Paul Gortmaker wrote :
> The one common thread here for all the patches is that we also
> scrap the .remove functions which would only be used for module
> unload (impossible) and driver unbind.  For the drivers here, there
> doesn't seem to be a sensible unbind use case (vs. e.g. a multiport
> PCI ethernet driver where one port is unbound and passed through to
> a kvm guest or similar).  Hence we just explicitly disallow any
> driver unbind operations to help prevent root from doing something
> illogical to the machine that they could have done previously.
> 
> We've already done this for drivers/tty/serial/mpsc.c previously.
> 
> Build tested for allmodconfig on ARM64 and powerpc for tty/tty-testing.
> 

So, how does this actually build test atmel_serial?

A proper solution would be to actually make it a tristate and allow
building as a module. I think it currently fails because of
console_initcall() but that is certainly fixable.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
