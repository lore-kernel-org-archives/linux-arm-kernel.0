From: davem@davemloft.net (David Miller)
Date: Thu, 09 Jul 2015 21:44:05 -0700 (PDT)
Subject: [RFT PATCH] net: axienet: Fix devm_ioremap_resource return
 value check
In-Reply-To: <1436448080-24775-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1436448080-24775-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <20150709.214405.325044957551402588.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Date: Thu,  9 Jul 2015 22:21:20 +0900

> Value returned by devm_ioremap_resource() was checked for non-NULL but
> devm_ioremap_resource() returns IOMEM_ERR_PTR, not NULL. In case of
> error this could lead to dereference of ERR_PTR.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> Cc: <stable@vger.kernel.org>
> Fixes: 46aa27df8853 ("net: axienet: Use devm_* calls")

Applied, thanks.
