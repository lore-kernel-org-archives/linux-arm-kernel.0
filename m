From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 8 May 2013 09:13:56 +0800
Subject: [PATCH] USB: set device dma_mask without reference to global data
In-Reply-To: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
References: <1367967232-10128-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAL411-qVnm0_wwdAiAp9eq_hYkXzFSmRMLAmknpSAG7Jb3bM9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 8, 2013 at 6:53 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Many USB host drivers contain code such as:
>
> if (!pdev->dev.dma_mask)
>         pdev->dev.dma_mask = &tegra_ehci_dma_mask;
>
> ... where tegra_ehci_dma_mask is a global. I suspect this code originated
> in commit 4a53f4e "USB: ehci-tegra: add probing through device tree" and
> was simply copied everywhere else.
>

One question: why device tree can't do this when create device?
