From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 26 Jul 2015 10:51:04 +0200 (CEST)
Subject: [PATCH] xen/events: Support event channel rebind on ARM
In-Reply-To: <1437845664-32098-1-git-send-email-julien.grall@citrix.com>
References: <1437845664-32098-1-git-send-email-julien.grall@citrix.com>
Message-ID: <alpine.DEB.2.11.1507261049540.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 25 Jul 2015, Julien Grall wrote:
> +/*
> + * Events delivered via platform PCI interrupts are always
> + * routed to vcpu 0 and hence cannot be rebound.
> + */
> +#define xen_support_evtchn_rebind()	\
> +	(!xen_hvm_domain() || xen_have_vector_callback)

Make this an inline please.

Thanks,

	tglx
