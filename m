From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 30 Mar 2015 16:17:03 +0800
Subject: [PATCH v2 1/3] mfd: provide RTC resource in MT6397 MFD
In-Reply-To: <20150318073045.GE3318@x1>
References: <1426657537-41414-1-git-send-email-eddie.huang@mediatek.com>
 <1426657537-41414-2-git-send-email-eddie.huang@mediatek.com>
 <20150318073045.GE3318@x1>
Message-ID: <1427703423.26464.16.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Wed, 2015-03-18 at 07:30 +0000, Lee Jones wrote:
> On Wed, 18 Mar 2015, Eddie Huang wrote:
> 
> > Provide MT6397 RTC interrupt, base address, and register in
> > MT6397 MFD.
> > 
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >  drivers/mfd/mt6397-core.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> > index b61c4eb..ef431d8 100644
> > --- a/drivers/mfd/mt6397-core.c
> > +++ b/drivers/mfd/mt6397-core.c
> > @@ -21,9 +21,24 @@
> >  #include <linux/mfd/mt6397/core.h>
> >  #include <linux/mfd/mt6397/registers.h>
> >  
> > +static const struct resource mt6397_rtc_resources[] = {
> > +	{
> > +		.start = 0xe000,
> > +		.end   = 0xe03e,
> 
> I'd like to see these defined please.
> 
Sure, will change to use define next round.

Eddie
