From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 07 May 2014 00:16:22 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NCAxLzJdIEFSTTogZHRzOiBpbXg1MS1ldWtyZWEtbWJp?=
 =?UTF-8?B?bXhzZDUxLWJhc2Vib2FyZDogQWRkIENBTiBzdXBwb3J0?=
In-Reply-To: <CAOMZO5DZFfC1NTF3gWGpCVwkOnzUi9npsLkPZioYrvDSKbFVGw@mail.gmail.com>
References: <1399404113-29207-1-git-send-email-fabio.estevam@freescale.com>
 <1399404776.560722294@f389.i.mail.ru>
 <CAOMZO5DZFfC1NTF3gWGpCVwkOnzUi9npsLkPZioYrvDSKbFVGw@mail.gmail.com>
Message-ID: <1399407382.993818541@f133.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, 6 May 2014 17:04:44 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> On Tue, May 6, 2014 at 4:32 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> >> +     can0: can at 0 {
> >> +             pinctrl-names = "default";
> >> +             pinctrl-0 = <&pinctrl_can>;
> >> +             compatible = "microchip,mcp2515";
> >> +             reg = <0>;
> >> +             clocks = <&clk24M>;
> >> +             spi-max-frequency = <1000000>;
> >
> > This should be of course 10000000, or removed completely
> > since driver already applies such limitation to the SPI bus.
> > I think Shawn can fix this during commit.
> 
> Yes, this should be 10MHz.
> 
> Thanks for the review.
> 
> Eric,
> 
> I forgot to Cc you on v4. Besides the 10MHz error above, does it look good?

Yes.
In fact, I would have changed the regulator name to the "CAN_RST" to
match the functionality, but this is nit-picking.

---
