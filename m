From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 10 Oct 2017 16:50:46 +0800
Subject: [PATCH v3 01/12] mmc: mediatek: add support of mt2701/mt2712
In-Reply-To: <d682718b-4b62-efa8-0756-ee0fa72fc1a1@gmail.com>
References: <1507604480-23246-1-git-send-email-chaotian.jing@mediatek.com>
 <1507604480-23246-2-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFrqv5tt8Exq1msUBbMEROam2c+YnStazsf5SPj-NLrGSg@mail.gmail.com>
 <1507620951.19789.7.camel@mhfsdcap03>
 <CAPDyKFppTCdaMizSGTjrfgsbMuHCsNi+knHVf9ibxgrAQ0GD2w@mail.gmail.com>
 <1507623748.19789.10.camel@mhfsdcap03>
 <d682718b-4b62-efa8-0756-ee0fa72fc1a1@gmail.com>
Message-ID: <1507625446.19789.12.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-10 at 10:32 +0200, Matthias Brugger wrote:
> 
> On 10/10/2017 10:22 AM, Chaotian Jing wrote:
> > On Tue, 2017-10-10 at 10:09 +0200, Ulf Hansson wrote:
> >> On 10 October 2017 at 09:35, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> >>> On Tue, 2017-10-10 at 09:26 +0200, Ulf Hansson wrote:
> >>>> [...]
> >>>>
> >>>>> +
> >>>>> +static const struct of_device_id msdc_of_ids[] = {
> >>>>> +       { .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
> >>>>> +       { .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
> >>>>> +       { .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
> >>>>> +       { .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
> >>>>> +       {}
> >>>>> +};
> >>>>> +MODULE_DEVICE_TABLE(of, msdc_of_ids);
> >>>>
> >>>> As already stated in the other reply. These new compatible changes
> >>>> needs to be discussed and acked before the driver starts using them.
> >>>>
> >>>> In other words, make patch3 to precede this one.
> >>> but, then there will have a probe issue as mentioned in previous mail
> >>> list. that's why I separate the binding file changes to 2 patches.
> >>
> >> That sounds seriously wrong. Aren't the bindings backwards compatible?
> >>
> >> Kind regards
> >> Uffe
> > 
> > As Matthias mentioned before:
> > "
> >>> NAK, this has to be:
> >>> You have to add the fallback compatible ("mediatek,mt8135-mmc") to
> > the binding
> >>> description as otherwise the driver does not get probed.
> >>>
> >>> Regards,
> >>> Matthias
> > "
> > the original compatible in driver is "mediatek,mt8135-mmc", so that if
> > drop "mediatek,mt8135-mmc" in bindings file(User may refer it and drop
> > "mediatek,mt8135-mmc" in their DTS), the driver will not get probed.
> > 
> 
> If you change the driver as you did in this patch, then there is no probing problem.
> 
> Regards,
> Matthias

Okay, will make patch3 to precede this one at next version.
