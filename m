From: notasas@gmail.com (Grazvydas Ignotas)
Date: Sun, 20 Sep 2015 00:12:13 +0300
Subject: [PATCH 2/2] ARM: dts: Fix WLAN regression on omap5-uevm
In-Reply-To: <CAOCHtYisPQ2g0GCD4NF7m14TchfaZ+k3UedPoaA0Rjtpo9ug+g@mail.gmail.com>
References: <1442593745-16725-1-git-send-email-tony@atomide.com>
 <1442593745-16725-3-git-send-email-tony@atomide.com>
 <CAOCHtYh3pDg6_mdX71G=L5Vz-mOmBnerwR5pjumq5jYQ-tN5Pw@mail.gmail.com>
 <20150918165109.GB8020@atomide.com>
 <CAOCHtYisPQ2g0GCD4NF7m14TchfaZ+k3UedPoaA0Rjtpo9ug+g@mail.gmail.com>
Message-ID: <CANOLnOP-WNcnDfQSDuHC_SN5vL8uNMWaeV3zNU7tcqNjGodURA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 9:39 PM, Robert Nelson <robertcnelson@gmail.com> wrote:
> On Fri, Sep 18, 2015 at 11:51 AM, Tony Lindgren <tony@atomide.com> wrote:
>> * Robert Nelson <robertcnelson@gmail.com> [150918 09:45]:
>>> On Fri, Sep 18, 2015 at 11:29 AM, Tony Lindgren <tony@atomide.com> wrote:
>>> > Commit 99f84cae43df ("ARM: dts: add wl12xx/wl18xx bindings") added
>>> > device tree bindings for the TI WLAN SDIO on many omap variants.
>>> >
>>> > I recall wondering how come omap5-uevm did not have the WLAN
>>> > added and this issue has been bugging me for a while now, and
>>> > I finally tracked it down to a bad pinmux regression, and a missing
>>> > deferred probe handling for the 32k clock from palmas that's
>>> > requested by twl6040.
>>> >
>>> > Basically 392adaf796b9 ("ARM: dts: omap5-evm: Add mcspi data")
>>> > added pin muxing for mcspi4 that conflicts with the onboard
>>> > WLAN. While the omap5-uevm docs say the WLAN is not populated,
>>> > this was probably only the case for initial prototypes. Both
>>> > omap5-uevm boards I have have WLAN populated.
>>>
>>> Production boards from svtronics don't populate the wlan..
>>>
>>> http://www.svtronics.com/EVM/OMAP5432/5432
>>>
>>> quote: "WiFi not available on this model"
>
> Okay, got an email back from svtronics, there was a special omap5_uevm
> + wlan order option for production units.

The boards we bought came without wlan, so that seems to be the
"default" configuration.

I vote for using separate DT overlay for the wlan version to avoid
unnecessary probing. OTOH the pins are not exposed on expansion
connectors and should not conflict with custom peripherals, so no
strong opinion here.

Gra?vydas
