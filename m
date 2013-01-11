From: marvin24@gmx.de (Marc Dietrich)
Date: Fri, 11 Jan 2013 20:52:39 +0100
Subject: [PATCH v3 0/9] Migrate Tegra to common clock framework
In-Reply-To: <50F058BC.9090909@wwwdotorg.org>
References: <1357292453-28418-1-git-send-email-pgaikwad@nvidia.com>
 <2615017.79obOGziy2@ax5200p> <50F058BC.9090909@wwwdotorg.org>
Message-ID: <35738737.tYpi2RKzkU@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 January 2013 11:23:56 Stephen Warren wrote:
> On 01/11/2013 08:59 AM, Marc Dietrich wrote:
> > On Friday 11 January 2013 13:40:03 Prashant Gaikwad wrote:
> >> On Thursday 10 January 2013 02:14 AM, Stephen Warren wrote:
> >>> On 01/09/2013 10:34 AM, Stephen Warren wrote:
> ...
> 
> >>> Your changes don't actually cause the driver to break though, since it
> >>> abuses clk_get_sys() to retrieve clocks under a different driver name,
> >>> which matches what the clock driver provides. However, I think you
> >>> should also include the following patch at the end of your series to fix
> >>> 
> >>> this up, so the clock looking happens through device tree:
> >>>> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> >>>> index d8826ed..6d44076 100644
> >>>> --- a/drivers/staging/nvec/nvec.c
> >>>> +++ b/drivers/staging/nvec/nvec.c
> >>>> @@ -770,7 +770,7 @@ static int tegra_nvec_probe(struct platform_device
> >>>> *pdev)>>
> >>>> 
> >>>>                  return -ENODEV;
> >>>>          
> >>>>          }
> >>>> 
> >>>> -       i2c_clk = clk_get_sys("tegra-i2c.2", "div-clk");
> >>>> +       i2c_clk = clk_get(&pdev->dev, "div-clk");
> >>>> 
> >>>>          if (IS_ERR(i2c_clk)) {
> >>>>          
> >>>>                  dev_err(nvec->dev, "failed to get controller
> >>>>                  clock\n");
> >>>>                  return -ENODEV;
> >> 
> >> Included in the latest patches sent.
> > 
> > em, not yet in V4.
> 
> It's in V2 of the other series Prashant posted which sits on top of the
> CCF rework series.

ahh, sorry - I didn't see it because of the changed subject line.

> > Maybe you can also adjust the TODO (2nd entry) file now
> > that this issue is fixed.
> 
> I'll try to remember to repost an updated version of the patch which
> does that...

no need if it just adds this change. I'll need to update the file anyway soon.

Thanks

Marc
