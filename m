From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Thu, 07 May 2015 17:46:47 +0300
Subject: [PATCH 1/2] coresight: replicator: Add Qualcomm CoreSight
 Replicator driver
In-Reply-To: <1430427225.2187.15.camel@x220>
References: <1430310000-10867-1-git-send-email-ivan.ivanov@linaro.org>
 <1430310000-10867-2-git-send-email-ivan.ivanov@linaro.org>
 <1430427225.2187.15.camel@x220>
Message-ID: <1431010007.21307.10.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Thu, 2015-04-30 at 22:53 +0200, Paul Bolle wrote:
> On Wed, 2015-04-29 at 15:19 +0300, Ivan T. Ivanov wrote:
> 
> > +config CORESIGHT_QCOM_REPLICATOR
> > +       bool "Qualcomm CoreSight Replicator driver"
> > +       help
> > +                       This enables support for CoreSight link and sink driver that are
> > +                       responsible for transporting and collecting the trace data
> > +                       respectively. Link and sinks are dynamically aggregated with a trace
> > +                       entity at run time to form a complete trace path.
> 
> > --- a/drivers/hwtracing/coresight/Makefile
> > +++ b/drivers/hwtracing/coresight/Makefile
> 
> > +obj-$(CONFIG_CORESIGHT_QCOM_REPLICATOR) += coresight-replicator-qcom.o
> 
> CORESIGHT_QCOM_REPLICATOR is a bool symbol. So
> coresight-replicator-qcom.o will never be part of a module.
> 

Thank you. I am going to fallow approach taken by Mathieu in [1].
Is this OK with you?

Regards,
Ivan 

[1] https://lkml.org/lkml/2015/5/6/524
