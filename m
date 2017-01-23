From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 23 Jan 2017 20:02:46 +0100
Subject: [PATCH v4 0/9] meson-gx: reset RGMII PHYs and configure TX delay
In-Reply-To: <m24m0p38sk.fsf@baylibre.com>
References: <20170120152232.13943-1-martin.blumenstingl@googlemail.com>
 <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
 <m24m0p38sk.fsf@baylibre.com>
Message-ID: <CAFBinCCoQpidWA9yTEBQ1rEomd33Sqouo3h86b2gmWHh5fcRag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 7:55 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
>> This series adds the reset GPIOs for the (external) ethernet PHYs on all
>> GXBB boards.
>> Additionally it provides a ethernet PHY node which can be used to specify
>> PHY-specific properties (this may be required if more boards require the
>> "eee-broken-1000t" for the RTL8211F ethernet PHY). To make all board .dts
>> consistent I chose to add the PHY node also for boards which don't have a
>> RTL8211F PHY.
>>
>> Patch #7 from this series also removes ethernet support for the P200
>
> I think you mean P201 here, right?
indeed, that's a left-over of my P200 / P201 mixup in v2 - please ignore this :(
I should have dropped that sentence completely since it's a lie in v3
(v3 states in changes since v2: "instead of dropping ethernet support
for P201 we simply re-configure it to RMII mode")
