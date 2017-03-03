From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 3 Mar 2017 21:12:16 +0100
Subject: [PATCH] ARM: DTS armada: Add support for 2 more mvebu model
In-Reply-To: <CA+_ehUwrn0x8616zyAuTwkv15ERA3Dqu9ATD+P71qZyU7j3bPw@mail.gmail.com>
References: <1488560855-421-1-git-send-email-ansuelsmth@gmail.com>
 <20170303172638.GD1488@lunn.ch>
 <CA+_ehUx0wcbfHMzPYehbEpQNu-a6vpHqHYJ4U7TY4BkzkLsRBw@mail.gmail.com>
 <20170303182112.GE1488@lunn.ch>
 <CA+_ehUwrn0x8616zyAuTwkv15ERA3Dqu9ATD+P71qZyU7j3bPw@mail.gmail.com>
Message-ID: <20170303201216.GF1488@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 07:59:51PM +0100, Ansuel Smith wrote:
> So i need to refactor the rango file and remove the extra part in the
> dts file, right?
> Also i need to create another dtsi file just for rango that use
> different flash size and gpio leds
> Wouldn't be a waste create one dtsi file just for the rango?

Please do not top post.

For the GPIO LEDs look at cobra, caiman as examples. The LEDs for
rango go in rango.dts.

The flash at d0000 node in armada-385-linksys.dtsi should be moved into
another .dtsi file, e.g. armada-385-linksys-caiman-cobra.dtsi.

So you end up with

armada-385-linksys-caiman.dts
 - armada-385-linksys.dtsi
 - armada-385-linksys-caiman-cobra.dtsi

armada-385-linksys-cobra.dts
 - armada-385-linksys.dtsi
 - armada-385-linksys-caiman-cobra.dtsi

armada-385-linksys-rango.dts
 - armada-385-linksys.dtsi

 Andrew
