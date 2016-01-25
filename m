From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 09:50:53 +0100
Subject: [PATCH v3 1/1] USB: core: let USB device know device node
In-Reply-To: <CAL411-qfzcynzc=YrepzcA6EmFuxy-Ri4xRQ+R-QVBDEPZXtZQ@mail.gmail.com>
References: <Pine.LNX.4.44L0.1601211015010.2275-100000@iolanthe.rowland.org>
 <2404899.20LhULZo7N@wuerfel>
 <CAL411-qfzcynzc=YrepzcA6EmFuxy-Ri4xRQ+R-QVBDEPZXtZQ@mail.gmail.com>
Message-ID: <1825868.A6VKDYvWaj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 January 2016 11:57:37 Peter Chen wrote:
> >> >
> >> >             hub at 3 { /* same external  hub, highspeed mode */
> >> >                     compatible = "usb2109,0812.591",
> >> >                                  "usb2109,0812",
> >> >                                  "usb2109,class9.0.1",
> >> >                                  "usb2109,class9.0",
> >> >                                  "usb2109,class9";
> >> >
> >> >                     #address-cells = <1>;
> >> >                     #size-cells = <0>;
> >> >                     reg = >;
> >> >
> >>
> >> Why "reg" is 3 here?
> >
> > My mistake. It should be hub at 1 and reg=<1>;
> >
> > I accidentally confused the port number and the device number.
> 
> I think it should be hub at 2 and reg=<0x2>.
> According to Alan, we should use xHCI numbering scheme when
> describing the ports of an xHCI root hub.

For a single-port root hub, that would be right. My PC has
two ports, so the first port has reg=<0x1> for SS and
reg=<0x3> for HS.

	Arnd
