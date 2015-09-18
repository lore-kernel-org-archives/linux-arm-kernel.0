From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Sep 2015 09:51:09 -0700
Subject: [PATCH 2/2] ARM: dts: Fix WLAN regression on omap5-uevm
In-Reply-To: <CAOCHtYh3pDg6_mdX71G=L5Vz-mOmBnerwR5pjumq5jYQ-tN5Pw@mail.gmail.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-3-git-send-email-tony@atomide.com>
 <CAOCHtYh3pDg6_mdX71G=L5Vz-mOmBnerwR5pjumq5jYQ-tN5Pw@mail.gmail.com>
Message-ID: <20150918165109.GB8020@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Nelson <robertcnelson@gmail.com> [150918 09:45]:
> On Fri, Sep 18, 2015 at 11:29 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Commit 99f84cae43df ("ARM: dts: add wl12xx/wl18xx bindings") added
> > device tree bindings for the TI WLAN SDIO on many omap variants.
> >
> > I recall wondering how come omap5-uevm did not have the WLAN
> > added and this issue has been bugging me for a while now, and
> > I finally tracked it down to a bad pinmux regression, and a missing
> > deferred probe handling for the 32k clock from palmas that's
> > requested by twl6040.
> >
> > Basically 392adaf796b9 ("ARM: dts: omap5-evm: Add mcspi data")
> > added pin muxing for mcspi4 that conflicts with the onboard
> > WLAN. While the omap5-uevm docs say the WLAN is not populated,
> > this was probably only the case for initial prototypes. Both
> > omap5-uevm boards I have have WLAN populated.
> 
> Production boards from svtronics don't populate the wlan..
> 
> http://www.svtronics.com/EVM/OMAP5432/5432
> 
> quote: "WiFi not available on this model"
> 
> They have an option to order a version with a "COM8Q" connector to add wlan...

Oh OK interesting.

> http://www.svtronics.com/EVM/OMAP5432/5432C
> 
> http://www.svtronics.com/EVM/OMAP5432/COM8Q
> 
> I'm not sure who to bug from that era, but the wlan populated devices
> might have been prototype only.

Hmm OK. Well as it's a SDIO card, it seems safe to add for now.
We may want to have a minimal separate dts file if the wiring is
different with the COM8Q card.

Regards,

Tony
