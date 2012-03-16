From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 16 Mar 2012 12:51:56 +0100
Subject: [PATCH v4] ARM: SPEAr600: Add device-tree support to SPEAr600
 boards
In-Reply-To: <4F630D39.2090905@st.com>
References: <1331890216-8361-1-git-send-email-sr@denx.de>
 <4F630D39.2090905@st.com>
Message-ID: <20120316115156.GG7757@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:21 Fri 16 Mar     , Viresh Kumar wrote:
> On 3/16/2012 3:00 PM, Stefan Roese wrote:
> > This patch adds a generic target for SPEAr600 board that can be
> > configured via the device-tree. Currently the following devices
> > are supported via the devicetree:
> > 
> > - VIC interrupts
> > - PL011 UART
> > - PL061 GPIO
> > - Synopsys DW I2C
> > - Synopsys DW ethernet
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > Cc: Viresh Kumar <viresh.kumar@st.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Acked-by: Viresh Kumar <viresh.kumar@st.com>
> 
> I have one query (as part of my learning of DT) to all DT experts:
> 
> > 
> > +                       /* local/cpu GPIO */
> > +                       gpio0: gpio at f0100000 {
> > +                               #gpio-cells = <2>;
> > +                               compatible = "arm,pl061", "arm,primecell";
> > +                               gpio-controller;
> > +                               reg = <0xf0100000 0x1000>;
> > +                               interrupt-parent = <&vic0>;
> > +                               interrupts = <18>;
> > +                       };
> > +
> > 
> 
> Can we add name property here:
> 				name = "gpio0"
> 
> So that we don't need to do below stuff.
no the nae of the device is f0100000.gpio"

so what do stefan is right

Best Regards,
J.
