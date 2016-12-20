From: romain.perier@free-electrons.com (Romain Perier)
Date: Tue, 20 Dec 2016 17:09:38 +0100
Subject: [PATCH v2 3/3] arm64: dts: marvell: Add ethernet switch
 definition for the ESPRESSObin
In-Reply-To: <20161220154234.GC30952@lunn.ch>
References: <20161220085138.3998-1-romain.perier@free-electrons.com>
 <20161220085138.3998-4-romain.perier@free-electrons.com>
 <20161220154234.GC30952@lunn.ch>
Message-ID: <c27998fd-3807-5c99-382b-b8d0d0f06526@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 20/12/2016 ? 16:42, Andrew Lunn a ?crit :
>> +&mdio {
>> +	switch0: switch0 at 0 {
>> +		compatible = "marvell,mv88e6085";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		reg = <1>;
>
> Ah, sorry, missed this last time. reg = <1>, that means switch0 at 1.
> That is a general rule for all device tree bindings.


Ahhh, I did not pay attention either :/
I will fix this.


>
>> +		mdio {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			reg = <1>;
>
> what is this reg value for?
>
>      Andrew
>

It was required to avoid a warning thrown by the mdio subsystem

Romain
