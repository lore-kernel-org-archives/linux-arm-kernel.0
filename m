From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 10 May 2012 08:25:27 +0300
Subject: [PATCH v3 1/2] omap: mailbox: enable mailbox irq per instance
In-Reply-To: <1336616370-28268-2-git-send-email-jgutierrez@ti.com>
References: <1336616370-28268-1-git-send-email-jgutierrez@ti.com>
 <1336616370-28268-2-git-send-email-jgutierrez@ti.com>
Message-ID: <CAK=WgbYhPVRtptozudJ0MLOq4jdQFrnds7UkkNL_Gdo0cuU4Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 5:19 AM, Juan Gutierrez <jgutierrez@ti.com> wrote:
> @@ -338,13 +341,13 @@ struct omap_mbox *omap_mbox_get(const char *name, struct notifier_block *nb)
> ? ? ? ?if (!mbox)
> ? ? ? ? ? ? ? ?return ERR_PTR(-ENOENT);
>
> + ? ? ? if (nb)
> + ? ? ? ? ? ? ? blocking_notifier_chain_register(&mbox->notifier, nb);
> +
> ? ? ? ?ret = omap_mbox_startup(mbox);
> ? ? ? ?if (ret)
> ? ? ? ? ? ? ? ?return ERR_PTR(-ENODEV);

Let's unroll blocking_notifier_chain_register when omap_mbox_startup fails.

Care to do a quick respin of this one with it ?

Thanks,
Ohad.
