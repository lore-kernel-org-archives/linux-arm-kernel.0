From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Jul 2018 09:56:52 -0600
Subject: RFC: tegra2/tegra3 automotive part changes
In-Reply-To: <3916c0ea-964e-42ab-8bfd-8e8edc5110ee@codethink.co.uk>
References: <3916c0ea-964e-42ab-8bfd-8e8edc5110ee@codethink.co.uk>
Message-ID: <fecd5597-1b04-6409-b87c-5cda54d43ce0@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2018 07:36 AM, Ben Dooks wrote:
> Hello, we are looking at up-streaming some of the work we have
> done on the tegra2 and tegra3 automotive devices. The automotive
> grade devices are close the commercial parts so we would like to
> discuss the core changes before submitting.
> 
> The changes are mostly with things like the clock setup and a
> few peripheral quirks (IIRC these are mostly MMC).
> 
> We are proposing to change the device-tree properties for the root
> node and any other affected devices from "nvidia,tegraXX" to a new
> "nvidia,tegraXXa". We would welcome discussion on whether to update
> all the devices at the start
> 
> An example of tegra30a.dtsi:
> 
> #include "tegra30.dtsi"
> 
> / {
>  ??????? compatible = "nvidia,tegra30a";
> 
>  ??????? clock at 60006000 {
>  ??????????????? compatible = "nvidia,tegra30a-car";
>  ??????? };
> }

This doesn't sound right. Auto and commercial parts are identical AFAIK; 
it's just qualification differences. Hence at most you'd add an extra 
compatible value and not remove the old one. Better might be to detect 
this at run-time from the fuses. I think we already do some of that 
already; search for speedo related code in arch/arm/mach-tegra/.
