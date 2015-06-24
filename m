From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 24 Jun 2015 10:34:43 +0100
Subject: [RFC PATCH v6 2/2] nvmem: Add Vybrid OCOTP and OCROM support
In-Reply-To: <20150624083529.GY2266@lukather>
References: <cover.1435066190.git.maitysanchayan@gmail.com>
 <b4a52f6c229bdabbfe9d21c03cb04593dde33ec4.1435066190.git.maitysanchayan@gmail.com>
 <20150624083529.GY2266@lukather>
Message-ID: <558A79B3.1010205@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/06/15 09:35, Maxime Ripard wrote:
> Hi,
>
> On Tue, Jun 23, 2015 at 07:14:57PM +0530, Sanchayan Maity wrote:
>> +static struct nvmem_config ocotp_config = {
>> +	.name = "soc_id",
>> +};
>> +
>> +static struct nvmem_config rom_config = {
>> +	.name = "rom_rev",
>> +};
>
> Srinivas, shouldn't we use the DT to setup these names, just like
> clock-output-names does for example?
These are the provider names, which would not change per board, I think. :-)

On the other hand if we are going to use generic drivers like 
"simple-mmio-nvmem" then having name DT bindings makes sense.

IMO, clock-output-names are analogous to nvmem consumers, which are 
obviously getting there names from cell node name ATM.


>
> This is very likely to change from one board to another, and defining
> a new compatible and/or driver for each board seems a bit fishy.
>
Do you have any particular example in mind, where the provider names 
would change per board?

--srini

> Maxime
>
