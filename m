From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 8 Jun 2016 09:46:45 +0100
Subject: [PATCH 1/2] phy: phy-qcom-ufs-qmp-14nm: Remove site specific OOM
 error message
In-Reply-To: <20160607183505.GJ2425@tarshish>
References: <1465321810-22470-1-git-send-email-peter.griffin@linaro.org>
 <20160607183505.GJ2425@tarshish>
Message-ID: <20160608084645.GA25004@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Tue, 07 Jun 2016, Baruch Siach wrote:

> Hi Peter,
> 
> On Tue, Jun 07, 2016 at 06:50:09PM +0100, Peter Griffin wrote:
> > kzalloc will issue its own error message including a dump_stack()
> > so remote the site specific message.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  drivers/phy/phy-qcom-ufs-qmp-14nm.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/phy/phy-qcom-ufs-qmp-14nm.c b/drivers/phy/phy-qcom-ufs-qmp-14nm.c
> > index 56631e7..958e9cc 100644
> > --- a/drivers/phy/phy-qcom-ufs-qmp-14nm.c
> > +++ b/drivers/phy/phy-qcom-ufs-qmp-14nm.c
> > @@ -139,11 +139,9 @@ static int ufs_qcom_phy_qmp_14nm_probe(struct platform_device *pdev)
> >  	int err = 0;
> >  
> >  	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> > -	if (!phy) {
> > -		dev_err(dev, "%s: failed to allocate phy\n", __func__);
> > +	if (!phy)
> >  		err = -ENOMEM;
> >  		goto out;
> > -	}
> 
> Are you sure? The 'goto' is now unconditional.

Your correct... that is not what I intended to do! Will send a v2.

regards,

Peter.
