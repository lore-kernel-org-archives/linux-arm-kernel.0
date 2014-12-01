From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 1 Dec 2014 15:13:41 -0200
Subject: [PATCH] ARM: imx6: fix bogus use of irq_get_irq_data
In-Reply-To: <1417453443-9179-1-git-send-email-marc.zyngier@arm.com>
References: <1417453443-9179-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAOMZO5AYAd5UVr7w_XAM0YPRNK0FQDS21QC-xwqq+dCsXogZ1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 1, 2014 at 3:04 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> The imx6 PM code seems to be quite creative in its use of irq_data,
> using something something that is very much a hardware interrupt
> number where we expect a virtual one.  Yes, it worked so far, but
> that's only cheer luck, and it will definitely explode in 3.19.
>
> Fix it by using a pair of helper functions that deal with the
> actual hardware.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks a lot, Marc! This fixes mx6q boot on linux-next:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
