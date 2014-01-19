From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 20 Jan 2014 00:09:25 +0100
Subject: How to support SDIO wifi/bt in DT
In-Reply-To: <CAOesGMjVpTEku+UJntewi3FXoeEPe9rJP4BBmbSesfFMtY9hnA@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
 <3215037.8HVCjAeS8g@wuerfel>
 <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
 <alpine.LFD.2.10.1401162204560.28907@knanqh.ubzr>
 <CAL_JsqKX2RT2E6uk3d35m+TWW7iuPFFiuZzOwd0xA9zMgqAZRw@mail.gmail.com>
 <alpine.LFD.2.10.1401171157340.28907@knanqh.ubzr>
 <CAOesGMjVpTEku+UJntewi3FXoeEPe9rJP4BBmbSesfFMtY9hnA@mail.gmail.com>
Message-ID: <20140119230924.GB8154@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 11:29:55AM -0800, Olof Johansson wrote :
> The "multi-slot" concept I was talking about was one host controller
> for several physical slots. Seems like at91 implements _and_ uses this
> but nobody else. However, it seems that they allocate one mmc host per
> slot, so the same model still works.
> 

I think we need to be extra careful about the DT bindings then because
adding a property in a slot is requiring handling that in the at91
driver whereas adding a common property for the various mmc hosts can be
done in the core code.

>From what I remember, it would be really good to put the DT parsing for
the slots in the core code but I only had a really quick look at that.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
