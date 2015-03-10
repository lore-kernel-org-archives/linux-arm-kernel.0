From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 21:27:59 +0100
Subject: [PATCH 1/2] phy: usbphy: Add dt documentation for Broadcom Cygnus
 USB PHY driver
In-Reply-To: <54EE67A6.609@broadcom.com>
References: <1424200821-16368-1-git-send-email-arun.ramamurthy@broadcom.com>
 <54E53278.70705@broadcom.com> <54EE67A6.609@broadcom.com>
Message-ID: <2079271.sEacVGN4vm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 February 2015 16:24:06 Arun Ramamurthy wrote:
> >>> Should I run this by Alan Stern?
> >>
> >> I've added him to Cc here. He clearly didn't know the background about
> >> the DT binding change, and should not need to, but he may have an opinion
> >> on what names we should use.
> >>
> >
> Arnd, should I re patch the ehci-platform driver to avoid phy-names 
> entirely? Alan, if not do you have an opinion on what the usb phy names 
> should be? The current patch uses "usbp" + port number such as "usbp0" , 
> "usbp1" etc

I think avoiding the phy names would be best here, but it requires a
kernel API change first, because we do not have a way to get a phy
by index as we do for other subsystems (e.g. clocks or gpios).

	Arnd
