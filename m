From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 25 Jan 2016 17:31:15 +0800
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <1825868.A6VKDYvWaj@wuerfel>
References: <Pine.LNX.4.44L0.1601211015010.2275-100000@iolanthe.rowland.org>
 <2404899.20LhULZo7N@wuerfel>
 <CAL411-qfzcynzc=YrepzcA6EmFuxy-Ri4xRQ+R-QVBDEPZXtZQ@mail.gmail.com>
 <1825868.A6VKDYvWaj@wuerfel>
Message-ID: <20160125093114.GA13749@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 09:50:53AM +0100, Arnd Bergmann wrote:
> On Monday 25 January 2016 11:57:37 Peter Chen wrote:
> > >> >
> > >> >             hub at 3 { /* same external  hub, highspeed mode */
> > >> >                     compatible = "usb2109,0812.591",
> > >> >                                  "usb2109,0812",
> > >> >                                  "usb2109,class9.0.1",
> > >> >                                  "usb2109,class9.0",
> > >> >                                  "usb2109,class9";
> > >> >
> > >> >                     #address-cells = <1>;
> > >> >                     #size-cells = <0>;
> > >> >                     reg = >;
> > >> >
> > >>
> > >> Why "reg" is 3 here?
> > >
> > > My mistake. It should be hub at 1 and reg=<1>;
> > >
> > > I accidentally confused the port number and the device number.
> > 
> > I think it should be hub at 2 and reg=<0x2>.
> > According to Alan, we should use xHCI numbering scheme when
> > describing the ports of an xHCI root hub.
> 
> For a single-port root hub, that would be right. My PC has
> two ports, so the first port has reg=<0x1> for SS and
> reg=<0x3> for HS.
> 

Yes, you are right.

Alan, do you know which physical number is larger for
the same port, HS or SS port? Is it spec defined or vendor defined?
I haven't found related information at xHCI spec.

-- 

Best Regards,
Peter Chen
