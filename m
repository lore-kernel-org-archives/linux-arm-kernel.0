From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 09 Jan 2017 14:52:50 -0800
Subject: [PATCH 0/5] meson-gx: reset RGMII PHYs and configure TX delay
In-Reply-To: <CAFBinCDpBew7wreNPn6=J3jKsw_Ok=Ed9_+Gxsefb661RvUdrA@mail.gmail.com>
 (Martin Blumenstingl's message of "Sat, 17 Dec 2016 21:36:55 +0100")
References: <20161202234739.22929-1-martin.blumenstingl@googlemail.com>
 <CAFBinCDpBew7wreNPn6=J3jKsw_Ok=Ed9_+Gxsefb661RvUdrA@mail.gmail.com>
Message-ID: <m2wpe37sn1.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Sat, Dec 3, 2016 at 12:47 AM, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>> This partially fixes the 1000Mbit/s ethernet TX throughput issues (on
>> networks which are not affected by the EEE problem, as reported here:
>> [1]).
>> The actual problem for the TX throughput issues was that the TX delay
>> was applied twice:
>> - once "accidentally" by the PHY (this was fixed with [2])
>> - once by the MAC because there was a hardcoded TX delay (of 2ns),
>>   this will be configurable with the changes from [0]
>>
>> These are the dts changes which belong to my other series (in v2
>> these patches were part of the other series, upon request of the
>> net maintainers I have split the .dts changes into their own series so
>> we are able to take both through different trees):
>> "[PATCH net-next v3 0/2] stmmac: dwmac-meson8b: configurable
>> RGMII TX delay": [0].
>> Thus this series depends on the ACK for the binding changes in the
>> other series!
>>
>> I based these changes on my other series "[PATCH v2 0/2] GXL and GXM
>> SCPI improvements": [3]
> the DT binding changes for the meson8b-dwmac driver were ACK'ed by Rob
> Herring, so you can proceed with this series once you applied the SCPI
> patches.

Series queued for v4.11,

Thanks,

Kevin
