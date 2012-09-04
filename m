From: andi@etezian.org (Andi Shyti)
Date: Tue, 4 Sep 2012 17:44:30 +0200
Subject: [PATCH v5 1/4] mfd: add syscon driver based on regmap
In-Reply-To: <20120904114601.GB13046@shlinux2.ap.freescale.net>
References: <1346728811-25788-1-git-send-email-b29396@freescale.com>
 <1346728811-25788-2-git-send-email-b29396@freescale.com>
 <20120904113545.GD4657@jack.whiskey>
 <20120904114601.GB13046@shlinux2.ap.freescale.net>
Message-ID: <20120904154430.GA4361@Jack.Whiskey>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 07:46:02PM +0800, Dong Aisheng wrote:
> On Tue, Sep 04, 2012 at 07:35:45PM +0800, Andi Shyti wrote:
> > Hi Dong,
> > 
> > On Tue, Sep 04, 2012 at 11:20:08AM +0800, Dong Aisheng wrote:
> > > +static int __devinit syscon_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > 
> > Do we really need this variable? Anyway you are using it only
> > once in the dev_info.
> > 
> Okay, i can remove it.

On Tue, Sep 04, 2012 at 04:16:59PM +0400, Sergei Shtylyov wrote:
>    But Dong definitely could use it more than once, so it seems useful.

[sorry for pasting your e-mail here]
yes, but he is using it only once and, it's easily
reachable with pdev->dev and anyway Dong is using &pdev->dev.

> > > +
> > > +	syscon = devm_kzalloc(&pdev->dev, sizeof(struct syscon),
> > > +			    GFP_KERNEL);
> > 
> > in case of error you are not freeing syscon.
> Do we need it for managed resource of syscon?

Yes, you're right :)

> > Moreover, in my opinion, some dev_err more should not heart
                                                           ^^
as Sergei points out is 'hurt'... mistype :)

> There's no much error cases here, most of them rarely fails and i don't feel
> we really need add.
> I don't know what dev_err you suggested to add?

For example some failure cases, anyway i read quickly the code
and I don't big see issues.

Andi
