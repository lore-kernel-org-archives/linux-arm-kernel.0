From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Mar 2013 11:42:47 -0600
Subject: [PATCH V2 3/5] ARM: DT: tegra114:add aliases and DMA requestor
 for serial controller
In-Reply-To: <20130310224219.GG4743@avionic-0098.mockup.avionic-design.de>
References: <1362852678-13421-1-git-send-email-ldewangan@nvidia.com>
 <1362852678-13421-4-git-send-email-ldewangan@nvidia.com>
 <20130310224219.GG4743@avionic-0098.mockup.avionic-design.de>
Message-ID: <513E1797.4010808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/2013 04:42 PM, Thierry Reding wrote:
> On Sat, Mar 09, 2013 at 11:41:16PM +0530, Laxman Dewangan wrote: 
> [...]
>> diff --git a/arch/arm/boot/dts/tegra114.dtsi 
>> b/arch/arm/boot/dts/tegra114.dtsi
> [...]
>> @@ -99,38 +106,50 @@ 0x70003000 0x40c>;	/* Mux registers */ };
>> 
>> -	serial at 70006000 { +	/* +	 * There are two serial driver i.e. 
>> 8250 based simple serial +	 * driver and APB DMA based serial 
>> driver for higher baudrate +	 * and performace. To enable the 
>> 8250 based driver, the compatible +	 * is
>> "nvidia,tegra114-uart", "nvidia,tegra20-uart" and to enable +	 *
>> the APB DMA based serial driver, the comptible is +	 *
>> "nvidia,tegra114-hsuart", "nvidia,tegra30-hsuart". +	 */ +	uarta:
>> serial at 70006000 {
> 
> I'm not sure if this is a good place for this comment. Perhaps it 
> should go into the binding documentation?

It is at least consistent with previous tegra20/30.dtsi. The two
compatible values are separate bindings, so a clue here re: which one
to go look at isn't a bad idea, although I agree that having each
binding document mention the other one would also be good.
