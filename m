From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Jul 2015 18:45:35 -0300
Subject: [PATCH v3 1/1] Serial: imx: add dev_pm_ops to support suspend to
 ram/disk
In-Reply-To: <CY1PR0301MB0843BEF6A40A0A28018E0D5D838C0@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1438203535-38028-1-git-send-email-shenwei.wang@freescale.com>
 <CAOMZO5Aj5PASPKRq47vmenDBSPMPHdLgSbJZXkhZu3MNYprqXA@mail.gmail.com>
 <CY1PR0301MB0843BEF6A40A0A28018E0D5D838C0@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <CAOMZO5DaZ+1Ud0RAX2RELz5c0zyZUo_X1y50gY2XwM5o0BeVmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 6:41 PM, Shenwei Wang
<Shenwei.Wang@freescale.com> wrote:

>> clk_enable() may fail, so you should check its return value.
>
> The check seems a little superfluous because the failure condition for clk_enable is
> (clk == NULL || IS_ERR(clk))
> Once this function is called which means the initialization of the driver is successful.

Not superfluos. You can't assume that clk_enable() will always be
successful. Better check its return value.
