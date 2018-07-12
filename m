From: cyndis@kapsi.fi (Mikko Perttunen)
Date: Thu, 12 Jul 2018 16:50:25 +0300
Subject: RFC: tegra2/tegra3 automotive part changes
In-Reply-To: <3916c0ea-964e-42ab-8bfd-8e8edc5110ee@codethink.co.uk>
References: <3916c0ea-964e-42ab-8bfd-8e8edc5110ee@codethink.co.uk>
Message-ID: <62581f70-4f55-05b4-5210-221698d501c7@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2018 04:36 PM, Ben Dooks wrote:
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
> 
> We don't think the changes are big enough to warrant their own
> Kconfig/defconfig updates.
> 

What kind of changes do you have? Tegra30a would point to a separate SoC 
revision of Tegra3 the existence of which I'm not aware of. If you can 
show some of the changes it would be easier to say how the system should 
be specified.

Thanks,
Mikko
