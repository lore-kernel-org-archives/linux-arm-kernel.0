From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 20 Aug 2018 20:20:38 +0200
Subject: [PATCH v2 06/29] mtd: Add support for reading MTD devices via
 the nvmem API
In-Reply-To: <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl>
 <20180817182720.6a6e5e8e@bbrezillon> <20180819133106.0420df5f@tock>
 <20180819184609.6dcdbb9a@bbrezillon>
 <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
Message-ID: <20180820202038.5d3dc195@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Aug 2018 11:43:34 +0100
Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> 
> Overall am still not able to clear visualize on how MTD bindings with 
> nvmem cells would look in both partition and un-partition usecases?
> An example DT would be nice here!!

Something along those lines:

	mtdnode {
		nvmem-cells {
			#address-cells = <1>;
			#size-cells = <1>;

			cell at 0 {
				reg = <0x0 0x14>;
			};
		};

		partitions {
			compatible = "fixed-partitions";
			#address-cells = <1>;
			#size-cells = <1>;

			partition at 0 {
				reg = <0x0 0x20000>;

				nvmem-cells {
					#address-cells = <1>;
					#size-cells = <1>;

					cell at 0 {
						reg = <0x0 0x10>;
					};
				};
			};
		};
	};
