From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 30 Aug 2010 10:10:00 -0400 (EDT)
Subject: [PATCH 17/74] ST SPEAr: Adding USB Host support
In-Reply-To: <16ef7fe197c3333deccdc6ff41d34ffeb0a8b71e.1283161023.git.viresh.kumar@st.com>
Message-ID: <Pine.LNX.4.44L0.1008301007010.1571-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Aug 2010, Viresh KUMAR wrote:

> From: Deepak Sikri <deepak.sikri@st.com>
> 

Missing patch description.

> Signed-off-by: Deepak Sikri <deepak.sikri@st.com>
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---


> --- /dev/null
> +++ b/drivers/usb/host/ehci-spear.c
> @@ -0,0 +1,210 @@

...

> +static const struct hc_driver ehci_spear_hc_driver = {
> +	.description		= hcd_name,
> +	.product_desc		= "SPEAr EHCI",
> +	.hcd_priv_size		= sizeof(struct spear_ehci),
> +
> +	/* generic hardware linkage */
> +	.irq			= ehci_irq,
> +	.flags			= HCD_MEMORY | HCD_USB2,
> +
> +	/* basic lifecycle operations */
> +	.reset			= ehci_spear_setup,
> +	.start			= ehci_run,
> +	.stop			= ehci_stop,
> +	.shutdown		= ehci_shutdown,
> +
> +	/* managing i/o requests and associated device resources */
> +	.urb_enqueue		= ehci_urb_enqueue,
> +	.urb_dequeue		= ehci_urb_dequeue,
> +	.endpoint_disable	= ehci_endpoint_disable,
> +

Missing .endpoint_reset.

Alan Stern
