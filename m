From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Tue, 25 Mar 2014 12:37:39 +0100
Subject: [PATCH RFC] ixp4xx_eth: Allow setting the MDIO bus name in
 platform data
In-Reply-To: <CAGVrzcaJ5LKE_HAvsmbnFxYsLbNwi9h9UYrz60AQ3z4DOZKwYw@mail.gmail.com>
References: <20140324151729.1b8e3bb5@marrow.netinsight.se>
 <m3r45r72u9.fsf@intrepid.localdomain>
 <CAGVrzcaJ5LKE_HAvsmbnFxYsLbNwi9h9UYrz60AQ3z4DOZKwYw@mail.gmail.com>
Message-ID: <20140325123739.05017fcf@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Mar 2014 13:42:29 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> 2014-03-24 13:34 GMT-07:00 Krzysztof Halasa <khc@pm.waw.pl>:
> > Simon K?gstr?m <simon.kagstrom@netinsight.net> writes:
> >
> >> Allows using e.g., a fixed MDIO bus with the ixp4xx_eth driver.
> >> Example:
> >
> >
> > Why do we need it? I'm not sure I know what constitutes a "fixed MDIO
> > bus".
> 
> This is a software emulation MDIO bus for when your Ethernet MAC is
> connected to a PHY which does not appear on the MDIO bus. This is
> typically used to provide the Ethernet driver with a link that is
> always seen as UP, when you cannot directly query it via MDIO/MDC.

Yes, exactly. We have a board which uses two of the ipx4xx NPE:s, one
which uses a real PHY via the ixp4xx_eth MDIO bus and one which uses
the fixed PHY driver.

To support this, we need this patch as the driver would otherwise
always look for the PHY on the ixp4xx_eth MDIO bus.

// Simon
