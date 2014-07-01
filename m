From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 1 Jul 2014 15:48:59 +0300
Subject: [PATCHv5 05/15] hwspinlock/omap: add support for dt nodes
In-Reply-To: <1398904476-26200-6-git-send-email-s-anna@ti.com>
References: <1398904476-26200-1-git-send-email-s-anna@ti.com>
 <1398904476-26200-6-git-send-email-s-anna@ti.com>
Message-ID: <CAK=WgbamDPN9EmKUu3+c3RbsQn1uhz5MGGvpWSSUJSUKyoH8Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Thu, May 1, 2014 at 3:34 AM, Suman Anna <s-anna@ti.com> wrote:
>  static int omap_hwspinlock_probe(struct platform_device *pdev)
>  {
> -       struct hwspinlock_pdata *pdata = pdev->dev.platform_data;
> +       struct device_node *node = pdev->dev.of_node;
>         struct hwspinlock_device *bank;
>         struct hwspinlock *hwlock;
>         struct resource *res;
>         void __iomem *io_base;
>         int num_locks, i, ret;
> +       int base_id = 0;

We shouldn't implicitly assume base_id is zero: let's explicitly
protect against potential subsequent invocations of
omap_hwspinlock_probe.

Thanks,
Ohad.
