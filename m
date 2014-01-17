From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 17 Jan 2014 11:44:23 +0100
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <20140117093909.GB2348@piout.net>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <20140116195819.GY15937@n2100.arm.linux.org.uk>
 <CAOesGMjZzwuOvt3iV+CDXZr5-hWvay_xaO-RH5syB1D-zGVu+A@mail.gmail.com>
 <20140117093909.GB2348@piout.net>
Message-ID: <20140117104423.GR17530@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The TI wilink chips (TiWi, wl12xx, wl18xx) have wifi on SDIO and BT on
> UART but they share the same clock. So, the next question would be what
> if I just want to enable one or the other (and take that decision at
> runtime) ?

At least for the clock is it not an issue. The generic clock framework
does "reference" counting. It will only turn the clock off when all
users have said to turn it off. So put a phandle to the clock in all
nodes which use it.

I've not looked at regulators, but i would hope it also does reference
counting of a regulators users.

	 Andrew
