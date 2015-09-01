From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 1 Sep 2015 09:17:00 +0100
Subject: [STLinux Kernel] [PATCH v2 3/4] remoteproc: Supply controller
 driver for ST's Remote Processors
In-Reply-To: <20150901075538.GJ4796@x1>
References: <1440757911-9120-1-git-send-email-lee.jones@linaro.org>
 <1440757911-9120-4-git-send-email-lee.jones@linaro.org>
 <55E08B34.9080102@mentor.com> <20150901075538.GJ4796@x1>
Message-ID: <20150901081700.GA30542@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 01 Sep 2015, Lee Jones wrote:

> On Fri, 28 Aug 2015, Nathan Lynch wrote:
> 
> > On 08/28/2015 05:31 AM, Lee Jones wrote:
> > > diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> > > index 28c711f..72e97d7 100644
> > > --- a/drivers/remoteproc/Kconfig
> > > +++ b/drivers/remoteproc/Kconfig
> > > @@ -77,4 +77,13 @@ config DA8XX_REMOTEPROC
> > >  	  It's safe to say n here if you're not interested in multimedia
> > >  	  offloading.
> > >  
> > > +config ST_REMOTEPROC
> > > +	tristate "ST remoteproc support"
> > > +	depends on ARCH_STI
> > > +	select REMOTEPROC
> > > +	help
> > > +	  Say y here to support ST's adjunct processors via the remote
> > > +	  processor framework.
> > > +	  This can be either built-in or a loadable module.
> > > +
> > 
> > The code uses reset_control_* APIs, so this should depend on
> > RESET_CONTROLLER, no?
> 
> There's no need to explicitly depend on RESET_CONTROLLER.
> 
> With !RESET_CONTROLLER the user is WARN()ed about using the reset_*
> API.

ARCH_STI selects RESET_CONTROLLER, so it will always be enabled.

regards,

Peter.
