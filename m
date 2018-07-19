From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 19 Jul 2018 12:07:05 +0100
Subject: [PATCH 1/3] tty/serial_core: add ISO7816 infrastructure
In-Reply-To: <20180713080129.2ifw7crjksvaxxpq@M43218.corp.atmel.com>
References: <20180711131638.12622-1-ludovic.desroches@microchip.com>
 <20180711131638.12622-2-ludovic.desroches@microchip.com>
 <20180712145808.GA22502@kroah.com>
 <20180713080129.2ifw7crjksvaxxpq@M43218.corp.atmel.com>
Message-ID: <20180719120705.4a2fde04@alans-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >   
> > > +	if (!port->iso7816_config)
> > > +		return -ENOIOCTLCMD;  
> > 
> > Why this error value?
> >   
> 
> It was a mimic of RS485.

Which is what you want - it means the upper tty layer knows to offer the
ioctl to other places and then return appropriately.

Alan
