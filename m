From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 21 Aug 2018 07:07:34 +0200
Subject: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
In-Reply-To: <20180820232748.608c3667@tock>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl>
 <20180817182720.6a6e5e8e@bbrezillon> <20180819133106.0420df5f@tock>
 <20180819184609.6dcdbb9a@bbrezillon>
 <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
 <20180820202038.5d3dc195@bbrezillon> <20180820232748.608c3667@tock>
Message-ID: <20180821070734.6dd1734d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Aug 2018 23:27:48 +0200
Alban <albeu@free.fr> wrote:

> On Mon, 20 Aug 2018 20:20:38 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> 
> > On Mon, 20 Aug 2018 11:43:34 +0100
> > Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> >   
> > > 
> > > Overall am still not able to clear visualize on how MTD bindings with 
> > > nvmem cells would look in both partition and un-partition usecases?
> > > An example DT would be nice here!!    
> > 
> > Something along those lines:  
> 
> We must also have a compatible string on the nvmem-cells node to make
> sure we don't clash with the old style MTD partitions,

That's not possible, because we don't have a reg prop in the
nvmem-cells node.

> or some other
> device specific binding.

This one might happen.

Was Rob okay with this compatible? If he was, I guess we can go for
this binding. Srinivas, any objection?

> 
> > 
> > 	mtdnode {
> > 		nvmem-cells {  
>                         compatible = "nvmem-cells";
> > 			#address-cells = <1>;
> > 			#size-cells = <1>;
> > 
> > 			cell at 0 {
> > 				reg = <0x0 0x14>;
> > 			};
> > 		};
> > 
> > 		partitions {
> > 			compatible = "fixed-partitions";
> > 			#address-cells = <1>;
> > 			#size-cells = <1>;
> > 
> > 			partition at 0 {
> > 				reg = <0x0 0x20000>;
> > 
> > 				nvmem-cells {  
>                                         compatible = "nvmem-cells";
> > 					#address-cells = <1>;
> > 					#size-cells = <1>;
> > 
> > 					cell at 0 {
> > 						reg = <0x0 0x10>;
> > 					};
> > 				};
> > 			};
> > 		};
> > 	};  
> 
> 
> Alban
