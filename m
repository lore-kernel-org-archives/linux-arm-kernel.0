From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 30 Aug 2016 09:54:09 -0700
Subject: [PATCH v8 01/18] remoteproc: st_slim_rproc: add a slimcore rproc
 driver
In-Reply-To: <20160830123453.GG10121@dell>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
 <1472223413-7254-2-git-send-email-peter.griffin@linaro.org>
 <20160830123453.GG10121@dell>
Message-ID: <20160830165409.GM15161@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 30 Aug 05:34 PDT 2016, Lee Jones wrote:

Thanks for your review Lee.

> On Fri, 26 Aug 2016, Peter Griffin wrote:
[..]
> > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > index 1a8bf76a..06765e0 100644
> > --- a/drivers/remoteproc/Kconfig
> > +++ b/drivers/remoteproc/Kconfig
> > @@ -100,4 +100,12 @@ config ST_REMOTEPROC
> >  	  processor framework.
> >  	  This can be either built-in or a loadable module.
> >  
> > +config ST_SLIM_REMOTEPROC
> > +	tristate "ST Slim remoteproc support"
> > +	select REMOTEPROC
> > +	help
> > +	  Say y here to support firmware loading on IP based around
> > +	  the Slim core.
> > +	  If unsure say N.

Saw one more thing when browsing through...

As this piece of code doesn't do anything on its own and is going to be
selected by the "function driver" I don't think this should be
user-selectable.

Regards,
Bjorn
