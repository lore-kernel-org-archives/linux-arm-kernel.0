From: Peter.Chen@freescale.com (Peter Chen)
Date: Fri, 27 Mar 2015 01:21:41 +0000
Subject: Need a phy function to enable / disable usb squelch detection
In-Reply-To: <55145B46.9020501@redhat.com>
References: <55145B46.9020501@redhat.com>
Message-ID: <BN3PR0301MB08495F972481336D9DA86A8A81090@BN3PR0301MB0849.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> Hi Kishon,
> 
> I've been debugging why some devices do not work with the musb otg
> controller found on Allwinner SoC-s, and the conclusion is not good, the
> Android kernel does a poke to the phy before releasing the usb reset.
> 
> Now you did not want me to introduce any sunxi specific / private phy
> functions in my initial patch-series for adding sunxi support, but in this case I do
> not really see an alternative, as this is a very platform specific hack to work
> around an issue with the phy-s squelch detection which causes it to see a
> squelch when reset is released switching it to high speed mode when a lo
> speed device is connected, after which things fall apart.
> 

The nofity_connect API at struct usb_phy may satisfy your requirement,
it will be called after bus rest has finished.

Peter
