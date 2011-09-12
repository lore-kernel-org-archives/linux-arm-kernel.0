From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Sep 2011 16:06:08 +0200
Subject: [PATCH 2/2] mmc: mmci: simplify err check in mmci_post_request
In-Reply-To: <1314624959-4634-3-git-send-email-per.forlin@linaro.org>
References: <1314624959-4634-1-git-send-email-per.forlin@linaro.org>
	<1314624959-4634-3-git-send-email-per.forlin@linaro.org>
Message-ID: <CACRpkdYq1eWCNtQB9BVJ814MU+m6CBRuOLySPpVAiyj2DpJ2vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 3:35 PM, Per Forlin <per.forlin@linaro.org> wrote:

> The error condition indicates that mmci_post_request() should cleanup
> after the mmci_pre_request(). In this case the resources allocated by
> device_prep_slave_sg() are freed by calling dmaengine_terminate_all().
> dma_unmap_sg() should always be performed if the host_cookie is set.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
