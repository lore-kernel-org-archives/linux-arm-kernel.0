From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Apr 2014 12:48:49 +0100
Subject: [PATCH 01/10] of: Keep track of populated platform devices
In-Reply-To: <20140429125657.65910C4089D@trevor.secretlab.ca>
References: <1398707877-22596-1-git-send-email-pawel.moll@arm.com>
 <1398707877-22596-2-git-send-email-pawel.moll@arm.com>
 <CAL_JsqJxWoxNL=P0SJm+Q1rTRGTpMkzmzTJDbFq2P1vPH4XxZQ@mail.gmail.com>
 <20140429125657.65910C4089D@trevor.secretlab.ca>
Message-ID: <1398858529.24255.3.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-04-29 at 13:56 +0100, Grant Likely wrote:
> > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > index 404d1da..0ae757a 100644
> > > --- a/drivers/of/platform.c
> > > +++ b/drivers/of/platform.c
> > > @@ -204,7 +204,8 @@ static struct platform_device *of_platform_device_create_pdata(
> > >  {
> > >         struct platform_device *dev;
> > >
> > > -       if (!of_device_is_available(np))
> > > +       if (!of_device_is_available(np) ||
> > > +                       of_node_check_flag(np, OF_POPULATED))
> > 
> > This and the amba case should be a test_and_set operation to avoid a
> > race condition.
> 
> Yes. It is an unlikely condition at the time that Pawel is handling, but
> it should also work for later calls to of_platform_populate() which may
> happen at runtime and in parallel.

Sure thing, will fix.

Thanks!

Pawel
