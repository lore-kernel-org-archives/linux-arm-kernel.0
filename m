From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Feb 2013 11:19:14 +0000
Subject: [PATCH 1/8] USB: EHCI: make ehci-spear a separate driver
In-Reply-To: <5117ede3.860e440a.097c.3508@mx.google.com>
References: <y> <1360522697-22902-1-git-send-email-y>
 <5117ede3.860e440a.097c.3508@mx.google.com>
Message-ID: <20130211111914.GD32455@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[...]

> -static struct of_device_id spear_ehci_id_table[] = {
> -       { .compatible = "st,spear600-ehci", },
> +static struct of_device_id SPEAr_ehci_id_table[] = {
> +       { .compatible = "st,SPEAr600-ehci", },
>         { },
>  };

This will break anyone using the documented binding, and anyone with an
existing dt will suddenly find their usb support broken.

Please don't change this.

Thanks,
Mark.
