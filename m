From: B29397@freescale.com (Chen Peter-B29397)
Date: Wed, 27 Feb 2013 08:57:07 +0000
Subject: [PATCH v8 8/8] usb: chipidea: udc: fix the oops when plugs in
 usb cable after rmmod gadget
In-Reply-To: <20130227084218.GL8016@arwen.pp.htv.fi>
References: <1360051215-27722-1-git-send-email-peter.chen@freescale.com>
 <1360051215-27722-9-git-send-email-peter.chen@freescale.com>
 <20130213084128.GB2426@arwen.pp.htv.fi>
 <20130217030951.GA1588@nchen-desktop>
 <20130226182141.GB2626@arwen.pp.htv.fi>
 <20130227031002.GB20402@nchen-desktop>
 <20130227084218.GL8016@arwen.pp.htv.fi>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803DCC3FE@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > > >  		} else {
> > > > +			if (ci->driver)
> > > > +				ci->driver->disconnect(&ci->gadget);
> > >
> > > This looks wrong. Why do you need to call ->disconnect() here ?
> >
> > When we disconnect usb cable from the host, we need to notify gadget
> module
> > disconnection occurs, the gadget module may not be unloaded in future.
> 
Sorry, can you point that?

Peter,
