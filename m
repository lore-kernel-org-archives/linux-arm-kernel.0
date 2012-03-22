From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Thu, 22 Mar 2012 14:43:16 +0000
Subject: Occasional crashes in suspend-resume with MMC transactions
In-Reply-To: <CANfBPZ9b=6dLbY2D3oAg=Gz_vwAOJ+KC_Bo5ugVJEwumeej_Bw@mail.gmail.com>
References: <B5906170F1614E41A8A28DE3B8D12143317FDFBB@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D12143317FF773@DBDE01.ent.ti.com>
 <CANfBPZ9b=6dLbY2D3oAg=Gz_vwAOJ+KC_Bo5ugVJEwumeej_Bw@mail.gmail.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D12143317FFAC0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2012 at 19:57:16, S, Venkatraman wrote:
[...]
> 
> I see (in 3.3) that the host controller driver does a "return ret" and
> that means the errors is propagated.
> Where is the return code lost /overridden ?
> 

The return code gets overridden due to the call to host->pdata->resume()
which always returns 0.

static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
{
        struct omap_mmc_platform_data *mmc = dev->platform_data;

        enable_irq(mmc->slots[0].card_detect_irq);
        return 0;
}

Regards,
Vaibhav
