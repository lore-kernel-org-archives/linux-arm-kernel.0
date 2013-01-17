From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 Jan 2013 12:43:23 -0200
Subject: [PATCH v6 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
In-Reply-To: <20727.57269.347099.324284@ipc1.ka-ro>
References: <1358416874-27011-1-git-send-email-peter.chen@freescale.com>
 <1358416874-27011-2-git-send-email-peter.chen@freescale.com>
 <CAOMZO5Chu0bcXPqn+wWHwAqLu+27DvLx1=Bzaffpd-bA2ahaAQ@mail.gmail.com>
 <20727.57269.347099.324284@ipc1.ka-ro>
Message-ID: <CAOMZO5DNVMAG3btGR7DeukgWaEaPe2zqm=EKAHQ5ovawq+BiWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 9:25 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:

> The equivalent of !cpu_is_mx51() would be
> strcmp(pdev->id_entry->name, "imx-udc-mx51") (without the '!') meaning
> id_entry->name is different from "imx-udc-mx51".

Yes, agree.

strcmp(pdev->id_entry->name, "imx-udc-mx51") is also better than
!strcmp(pdev->id_entry->name, "imx-udc-mx27"))

because in the case of another soc entry gets added, let's say
"imx-udc-mxyy" then

!strcmp(pdev->id_entry->name, "imx-udc-mx27")) will not correspond to
!cpu_is_mx51() anymore.
