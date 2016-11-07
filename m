From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 7 Nov 2016 14:09:31 +0000
Subject: [PATCH] ARM: tegra: nyan: Mark all USB ports as host
In-Reply-To: <20161107132854.GF12559@ulmo.ba.sec>
References: <20160918102852.6593-1-contact@paulk.fr>
 <20161107132854.GF12559@ulmo.ba.sec>
Message-ID: <13e7ff98-8bc2-ccf7-94bb-4e1d3c61b20d@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 07/11/16 13:28, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Sun, Sep 18, 2016 at 12:28:52PM +0200, Paul Kocialkowski wrote:
>> Nyan boards only have host USB ports (2 external, 1 internal), there is
>> no OTG-enabled connector.
>>
>> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>> ---
>>  arch/arm/boot/dts/tegra124-nyan.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Where is this information coming from? I don't have one of the Nyans
> myself, but one of the Tegra132 devices I have, which I think was
> derived from one of the Nyans uses one of the external host ports as
> forced recovery port, for which it would need OTG.
> 
> I suspect that the way to get U-Boot onto the Nyans is via tegrarcm?
> In that case I think one of the ports must be OTG.

It is true that the port on the back on the nyan-big can be used with
recovery mode. I was thinking that this is not a true OTG port as it is
just a 4-pin type A socket and does not have an ID pin. Thinking some
more about this the USB spec does include a "Host Negotiation Protocol
(HNP)" that allows a host and device to swap roles and so keeping it as
OTG seems valid afterall.

Cheers
Jon

-- 
nvpublic
