From: yong.wu@mediatek.com (Yong Wu)
Date: Tue, 15 Dec 2015 10:40:39 +0800
Subject: [PATCH v6 4/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <566F0821.4080507@gmail.com>
References: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com>
 <1449568153-15643-5-git-send-email-yong.wu@mediatek.com>
 <566F0821.4080507@gmail.com>
Message-ID: <1450147239.22854.25.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-12-14 at 19:19 +0100, Matthias Brugger wrote:
> 
> On 08/12/15 10:49, Yong Wu wrote:
> > This patch adds support for mediatek m4u (MultiMedia Memory Management
> > Unit).
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
[...]
> > +static void mtk_iommu_config(struct mtk_iommu_data *data,
> > +			     struct device *dev, bool enable)
> > +{
> > +	struct mtk_iommu_client_priv *head, *cur, *next;
> > +
> > +	head = dev->archdata.iommu;
> > +	list_for_each_entry_safe(cur, next, &head->client, client) {
> > +		mtk_smi_config_port(
> > +			data->larbdev[MTK_M4U_TO_LARB(cur->mtk_m4u_id)],
> > +			MTK_M4U_TO_PORT(cur->mtk_m4u_id), enable);
> 
> Use an extra variable for MTK_M4U_TO_LARB(cur->mtk-m4u_id), this makes 
> the code easier to read.

OK. Thanks.
I will fix it in next version.

> 
> Regards,
> Matthias
> 
> > +	}
> > +}
> > +
[...]
