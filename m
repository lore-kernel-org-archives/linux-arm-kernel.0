From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 29 Sep 2016 17:45:22 +0200
Subject: [PATCH] dmaengine: pxa_dma: remove unused function
In-Reply-To: <1475154561-12327-1-git-send-email-baoyou.xie@linaro.org> (Baoyou
 Xie's message of "Thu, 29 Sep 2016 21:09:21 +0800")
References: <1475154561-12327-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <87shsiaewd.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Baoyou Xie <baoyou.xie@linaro.org> writes:

> We get 1 warning when building kernel with W=1:
> drivers/dma/pxa_dma.c:1525:5: warning: no previous prototype for 'pxad_toggle_reserved_channel' [-Wmissing-prototypes]
>
> In fact, this function is called by no one, so this patch removes it.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Okay, yet I'd rather have a revert of commit c91134d91944 ("dmaengine: pxa_dma:
add support for legacy transition") , with the commit message saying:
    The conversion of the pxa architecture is now finished for all drivers, so this
    functions has fullfilled its purpose and can now be removed.

I have a similar patch in my internal tree, but yours can very well go in, as
long as it is a revert with a statement explaining why it is necessary now and
not before.

Cheers.

--
Robert
