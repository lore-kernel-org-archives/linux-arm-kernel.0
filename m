From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 10 May 2012 23:39:48 +0300
Subject: [PATCH v4 1/2] omap: mailbox: enable mailbox irq per instance
In-Reply-To: <1336680588-8572-2-git-send-email-jgutierrez@ti.com>
References: <1336680588-8572-1-git-send-email-jgutierrez@ti.com>
 <1336680588-8572-2-git-send-email-jgutierrez@ti.com>
Message-ID: <CAK=WgbZ6t-8woKujtTG20fLqSFJPU2VKpW=E_V6hus1HQ+tDxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 11:09 PM, Juan Gutierrez <jgutierrez@ti.com> wrote:
> The machine-specific omap2_mbox_startup is called only once
> to initialize the whole mbox module. Enabling mbox irq at
> startup is only enabling the irq of the very first mailbox
> instance created.
>
> The enable_irq function should be called every time a
> new mbox instance is created/opened, in the generic
> platform mailbox layer.
>
> Also, the notifier_block registration is called before
> enabling the mbox's irq to avoid possible race of receiving
> an interrupt without invoking the user's notifier callback.
>
> Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>

Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
