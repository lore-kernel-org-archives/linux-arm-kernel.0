From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 25 Nov 2016 12:01:28 +0000
Subject: [net-next PATCH v1 0/2] stmmac: dwmac-meson8b: configurable RGMII
 TX delay
In-Reply-To: <6a6af561-4e83-ca6e-d989-f421e18bce1e@laposte.net> (Sebastian
 Frias's message of "Fri, 25 Nov 2016 12:13:32 +0100")
References: <20161124143417.10178-1-martin.blumenstingl@googlemail.com>
 <1480002964.17538.131.camel@baylibre.com>
 <CAFBinCB7sXjXor++W+PW0-j_VxATRzhexjqHgXj2jD10tBpZFg@mail.gmail.com>
 <e6ca0941-e2e3-dd93-d4d3-8fbd76b60e17@gmail.com>
 <6a6af561-4e83-ca6e-d989-f421e18bce1e@laposte.net>
Message-ID: <yw1x60nbahuv.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian Frias <sf84@laposte.net> writes:

> On 24/11/16 19:55, Florian Fainelli wrote:
>> Le 24/11/2016 ? 09:05, Martin Blumenstingl a ?crit :
>>> Based on what I found it seems that rgmii-id, rgmii-txid and
>>> rgmii-rxid are supposed to be handled by the PHY.
>> 
>> Correct, the meaning of PHY_INTERFACE_MODE should be from the
>> perspective of the PHY device:
>> 
>> - PHY_INTERFACE_MODE_RGMII_TXID means that the PHY is responsible for
>> adding a delay when the MAC transmits (TX MAC -> PHY (delay) -> wire)
>> - PHY_INTERFACE_MODE_RGMII_RXID means that the PHY is responsible for
>> adding a delay when the MAC receives (RX MAC <- (delay) PHY) <- wire)
>> 
>
> Thanks for the explanation.
> Actually I had thought that the delay was to account for board routing
> (wires) between the MAC and the PHY.
> From your explanation it appears that the delay is to account for board
> routing (wires) between the PHY and the RJ45 socket.

The delay pertains to the RGMII link between MAC and PHY.  The external
connection is self-clocking.

-- 
M?ns Rullg?rd
