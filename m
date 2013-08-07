From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Aug 2013 22:17:31 +0200
Subject: [PATCH 06/12] dma: mmp_pdma: make the controller a DMA provider
In-Reply-To: <52027318.3080703@gmail.com>
References: <1375870770-14263-1-git-send-email-zonque@gmail.com>
 <201308071812.15420.arnd@arndb.de> <52027318.3080703@gmail.com>
Message-ID: <201308072217.31954.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 August 2013, Daniel Mack wrote:

> > Please have a look at the changes that Zhangfei Gao proposed in
> > http://comments.gmane.org/gmane.linux.ports.arm.kernel/249077
> > and see if you can do the same here.
> 
> Ok, I can do the same. As I can directly access dma_spec->args[0] from
> that context, that approach would also solve the problem with the
> hard-coded filter function, right?

You mean the problem of using the exported filter function pointer in
other drivers? No, since the filter function is used only for the non-DT
path, while the xlate function is only used for DT.

	Arnd
