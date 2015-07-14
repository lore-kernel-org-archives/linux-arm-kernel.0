From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 14 Jul 2015 13:41:29 +0900
Subject: [PATCH] serial: samsung: Remove redundant DEBUG_LL check
In-Reply-To: <55A46C4F.8050803@samsung.com>
References: <1436786331-5188-1-git-send-email-javier@osg.samsung.com>
 <55A46C4F.8050803@samsung.com>
Message-ID: <069e01d0bdef$59a73c70$0cf5b550$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski wrote:
> 
> On 13.07.2015 20:18, Javier Martinez Canillas wrote:
> > Commit 84f57d9e3685 ("tty: serial/samsung: fix modular build") fixed
> > build issues when the driver was built as a module. One of those was
> > that printascii is only accessible when the driver is built-in.
> >
> > But there is no need to check for defined(CONFIG_DEBUG_LL) since the
> > SERIAL_SAMSUNG_DEBUG Kconfig symbol already depends on DEBUG_LL.
> >
> > Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Kukjin Kim <kgene@kernel.org>

Thanks,
Kukjin

> >
> > ---
> >
> >  drivers/tty/serial/samsung.c | 1 -
> >  1 file changed, 1 deletion(-)
> 
> Although this redundancy is not harmful the patch seems fine, so:
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Best regards,
> Krzysztof
