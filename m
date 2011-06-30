From: b32955@freescale.com (Huang Shijie)
Date: Thu, 30 Jun 2011 09:50:15 +0800
Subject: [PATCH v7 1/3] MTD : add the common code for GPMI-NFC	controller
	driver
In-Reply-To: <20110629123803.GM21898@n2100.arm.linux.org.uk>
References: <1309335878-16678-1-git-send-email-b32955@freescale.com>
	<1309335878-16678-2-git-send-email-b32955@freescale.com>
	<20110629123803.GM21898@n2100.arm.linux.org.uk>
Message-ID: <4E0BD657.3070400@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell:
> On Wed, Jun 29, 2011 at 04:24:36PM +0800, Huang Shijie wrote:
>> +	dma_addr_t destination_phys = ~0;
>> +
>> +	if (virt_addr_valid(destination))
>> +		destination_phys = dma_map_single(dev, destination,
>> +						length, DMA_FROM_DEVICE);
>> +
>> +	if (dma_mapping_error(dev, destination_phys)) {
> This is buggy.  There is no guarantee that we'll keep using ~0 as the
> value for dma_mapping_error().  Please don't rely on this, but instead
> code this better to avoid having to play these games.
>
thanks a lot. I will change it in the next version.

>> +static int send_page_prepare(struct gpmi_nfc_data *this,
>> +			const void *source, unsigned length,
>> +			void *alt_virt, dma_addr_t alt_phys, unsigned alt_size,
>> +			const void **use_virt, dma_addr_t *use_phys)
>> +{
>> +	dma_addr_t source_phys = ~0;
>> +	struct device *dev = this->dev;
>> +
>> +	if (virt_addr_valid(source))
>> +		source_phys = dma_map_single(dev,
>> +				(void *)source, length, DMA_TO_DEVICE);
>> +
>> +	if (dma_mapping_error(dev, source_phys)) {
> Ditto.
>
Best Regards
Huang Shijie
