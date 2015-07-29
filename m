From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Jul 2015 19:11:22 -0300
Subject: [PATCH v3 1/1] Serial: imx: add dev_pm_ops to support suspend to
 ram/disk
In-Reply-To: <CY1PR0301MB08437D6E977C99821622976A838C0@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1438203535-38028-1-git-send-email-shenwei.wang@freescale.com>
 <CAOMZO5Aj5PASPKRq47vmenDBSPMPHdLgSbJZXkhZu3MNYprqXA@mail.gmail.com>
 <CY1PR0301MB0843BEF6A40A0A28018E0D5D838C0@CY1PR0301MB0843.namprd03.prod.outlook.com>
 <CAOMZO5DaZ+1Ud0RAX2RELz5c0zyZUo_X1y50gY2XwM5o0BeVmg@mail.gmail.com>
 <CY1PR0301MB08437D6E977C99821622976A838C0@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <CAOMZO5Drw9SAnocz2pBY2RhuQE7HbFrvdXhSWEqjiwxgvq2pgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 6:54 PM, Shenwei Wang
<Shenwei.Wang@freescale.com> wrote:

> I am very interesting to know if you could provide an example condition that may cause
> clk_enable failed in this callback function?

Let's check clk_enable definition:

int clk_enable(struct clk *clk)
{
    unsigned long flags;
    int ret;

    if (!clk)
        return 0;

    flags = clk_enable_lock();
    ret = clk_core_enable(clk->core);
    clk_enable_unlock(flags);

    return ret;
}

So if I see it right it returns 'int' not 'void' ;-)
