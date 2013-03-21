From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 21 Mar 2013 12:17:37 -0300
Subject: [PATCH 06/16] thermal: mvebu: Convert to devm_ioremap_resource()
In-Reply-To: <514B138A.7060203@cogentembedded.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <514B138A.7060203@cogentembedded.com>
Message-ID: <20130321151736.GB24246@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, Mar 21, 2013 at 06:04:58PM +0400, Sergei Shtylyov wrote:
> On 21-03-2013 2:36, Ezequiel Garcia wrote:
> 
> > Convert devm_request_and_ioremap() to the newly introduced
> > devm_ioremap_resource() which provides more consistent error handling.
> 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >   drivers/thermal/mvebu_thermal.c |    6 ++----
> >   1 files changed, 2 insertions(+), 4 deletions(-)
> 
> > diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
> > index ef04e4e..089b43d 100644
> > --- a/drivers/thermal/mvebu_thermal.c
> > +++ b/drivers/thermal/mvebu_thermal.c
> > @@ -86,11 +86,9 @@ static int mvebu_thermal_probe(struct platform_device *pdev)
> >   	if (!priv)
> >   		return -ENOMEM;
> >
> > -	priv->sensor = devm_request_and_ioremap(&pdev->dev, res);
> > -	if (!priv->sensor) {
> > -		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> > +	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
> > +	if (!priv->sensor)
> 
>     devm_ioremap_resource() returns error code, not NULL.
> 

Yes, you're right. Andrew has already pointed this out
and I'll fix it in the next round.

Thanks for the review!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
