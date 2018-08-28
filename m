From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 28 Aug 2018 11:20:31 +0100
Subject: [PATCH v2 06/29] mtd: Add support for reading MTD devices via the
 nvmem API
In-Reply-To: <20180823122921.6857d917@tock>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl> <20180817182720.6a6e5e8e@bbrezillon>
 <20180819133106.0420df5f@tock> <20180819184609.6dcdbb9a@bbrezillon>
 <5b8c30b8-41e1-d59e-542b-fef6c6469ff0@linaro.org>
 <20180820202038.5d3dc195@bbrezillon>
 <e0ec3194-fd3a-9b3d-fba8-f88447eb56e9@linaro.org>
 <20180821133916.3a1c51b1@eos>
 <6db14f9c-edd3-5e43-839c-953bb03097ff@linaro.org>
 <20180821150121.4408672f@bbrezillon> <20180823122921.6857d917@tock>
Message-ID: <58fd7ab3-c115-1f26-6d6e-677af6351239@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/08/18 11:29, Alban wrote:
> Let say I have a device that use the following binding:
> 
> device {
>      compatible = "example-device";
>      #address-cells = <2>;
>      #size-cells = <1>;
> 
>      child at 0,0 {
>          reg = <0x0 0x0>;
>          ...
>      };
> 
>      child at 1,2 {
>          reg = <0x1 0x2>;
>          ...
>      };
> 
> };
> 
> Now this binding already use the node address space for something,
> so putting a nvmem node as direct child would not work.

AFAIK, It should work but the we would get a DT warning this, as nvmem 
does not use of_address based apis to parse this. Which should be 
totally fixed!!

As discussed before once we add support to #address-cells and 
#size-cells in nvmem core this should not be a problem.


--srini
  Here it is
> quiet clear as we have 2 address cells, however even if the number of
> cells and the cells size would match it would still be conceptually
> wrong as both bindings then use the same address space for something
> different.
