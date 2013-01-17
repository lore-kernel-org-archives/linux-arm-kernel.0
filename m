From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 Jan 2013 09:13:19 -0200
Subject: [PATCH v6 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
In-Reply-To: <1358416874-27011-2-git-send-email-peter.chen@freescale.com>
References: <1358416874-27011-1-git-send-email-peter.chen@freescale.com>
 <1358416874-27011-2-git-send-email-peter.chen@freescale.com>
Message-ID: <CAOMZO5Chu0bcXPqn+wWHwAqLu+27DvLx1=Bzaffpd-bA2ahaAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 8:01 AM, Peter Chen <peter.chen@freescale.com> wrote:

>         /* make sure USB_CLK is running at 60 MHz +/- 1000 Hz */
> -       if (!cpu_is_mx51()) {
> +       if (!strcmp(pdev->id_entry->name, "imx-udc-mx27")) {]]

Shouldn't this be:
 if (!strcmp(pdev->id_entry->name, "imx-udc-mx51"))
