From: rafael@kernel.org (Rafael J. Wysocki)
Date: Tue, 19 Dec 2017 02:42:52 +0100
Subject: [PATCH V4] ACPI / GED: unregister interrupts during shutdown
In-Reply-To: <1513125448-6509-1-git-send-email-okaya@codeaurora.org>
References: <1513125448-6509-1-git-send-email-okaya@codeaurora.org>
Message-ID: <CAJZ5v0g0yULEwWwWooF=5qwjEmmVUoR=uFDm-WsmJd+DDtswiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 13, 2017 at 1:37 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Some GED interrupts could be pending by the time we are doing a reboot.
>
> Even though GED driver uses devm_request_irq() to register the interrupt
> handler, the handler is not being freed on time during a shutdown since
> the driver is missing a shutdown callback.
>
> If the ACPI handler is no longer available, this causes an interrupt
> storm and delays shutdown.
>
> 1. Don't use devm family of functions for IRQ registration/free
> 2. Keep track of the events since free_irq() requires the dev_id parameter
> passed into the request_irq() function.
> 3. Call free_irq() on both remove and shutdown explicitly.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Applied, thanks!
