From: Andrew.Jackson@arm.com (Andrew Jackson)
Date: Thu, 04 Dec 2014 09:43:57 +0000
Subject: [PATCH 4/5] ASoC: dwc: Add devicetree support for Designware I2S
In-Reply-To: <2041200.ZjakFFAZAU@wuerfel>
References: <547F3CAC.9050105@arm.com> <2041200.ZjakFFAZAU@wuerfel>
Message-ID: <54802CDD.6080000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/14 20:13, Arnd Bergmann wrote:
> On Wednesday 03 December 2014 16:39:08 Andrew Jackson wrote:
>> Convert to driver to use either platform_data or device-tree for configuration
>> of the device.  When using device-tree, the I2S block's configuration is read
>> from the relevant registers: this reduces the amount of information required in
>> the device tree.
>>
>> Signed-off-by: Andrew Jackson <Andrew.Jackson@arm.com>
> 
> I don't think we even have to worry about the platform_data case here:
> the only platform using this hardware in Linux is arm/mach-spear, and
> it defines a device node with a binding that is similar to the one you
> document here but that is not implemented in the driver.
> 
> So, I think for all practical purposes we can assume that nobody cares
> if you make incompatible changes as long as you don't introduce build
> regression.
> 
> Also, please adapt the 	arch/arm/boot/dts/spear13*.dts{,i} files
> as good as you can. They are broken in other ways too that you don't
> have to fix, just make them conform to the binding you add.
> 

Will do.  Although I had noticed those DT entries, I couldn't find anything in support of them.  I wasn't sure whether someone else was waiting in the wings (so as to speak) with a DT enabled Designware I2S driver. 

> 	Arnd
> 
> 
