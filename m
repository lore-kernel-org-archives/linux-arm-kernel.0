From: msalter@redhat.com (Mark Salter)
Date: Mon, 12 Sep 2011 10:12:44 -0400
Subject: [PATCH 10/24] C6X: time management
In-Reply-To: <alpine.LFD.2.02.1109091612150.2723@ionos>
References: <1314826019-22330-1-git-send-email-msalter@redhat.com>
	<1314826019-22330-11-git-send-email-msalter@redhat.com>
	<alpine.LFD.2.02.1109091612150.2723@ionos>
Message-ID: <1315836765.11280.1.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-09-09 at 16:19 +0200, Thomas Gleixner wrote:
> On Wed, 31 Aug 2011, Mark Salter wrote:
> > +	cd->cpumask		= cpumask_of(smp_processor_id());
> > +
> > +	clockevents_register_device(cd);
> > +
> > +	/* Set handler */
> > +	if (cd->irq != NO_IRQ)
> 
> How does a timer device work w/o interrupt ?

Heh, not very well. That check needs to happen earlier so we don't
register the device if we can't find the irq number.

--Mark
