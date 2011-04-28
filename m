From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 28 Apr 2011 17:15:13 +0800
Subject: [PATCH v2 1/3] ARM: mmp: add pxa910 mmc resource
In-Reply-To: <20110428091110.GO17290@n2100.arm.linux.org.uk>
References: <BANLkTi=XLp6hZ3H5rM6G32jhibz4xQo-Vg@mail.gmail.com>
	<20110428091110.GO17290@n2100.arm.linux.org.uk>
Message-ID: <BANLkTinZfCzrM0+WomZ4cS2mkQRkty9qYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 5:11 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 21, 2011 at 09:56:53AM +0800, Jun Nie wrote:
>> +static inline int pxa910_add_sdhost(int id, struct sdhci_pxa_platdata *data)
>> +{
>> + ? ? struct pxa_device_desc *d = NULL;
>> +
>> + ? ? switch (id) {
>> + ? ? case 0: d = &pxa910_device_sdh0; break;
>> + ? ? case 1: d = &pxa910_device_sdh1; break;
>> + ? ? case 2: d = &pxa910_device_sdh2; break;
>> + ? ? default:
>> + ? ? ? ? ? ? return -EINVAL;
>> + ? ? }
>> +
>> + ? ? return pxa_register_device(d, data, sizeof(*data));
>> +}
>
> How about:
>
> static inline int pxa910_add_sdhost(struct pxa_device_desc *dev,
> ? ? ? ?struct sdhci_pxa_platdata *data)
> {
> ? ? ? ?return pxa_register_device(dev, data, sizeof(*data));
> }
>
> #define pxa910_add_sdhost0(data) pxa910_add_sdhost(&pxa910_device_sdh0, data)
> #define pxa910_add_sdhost1(data) pxa910_add_sdhost(&pxa910_device_sdh1, data)
> #define pxa910_add_sdhost2(data) pxa910_add_sdhost(&pxa910_device_sdh2, data)
>
> instead - which seems more sane if you're going to call the function with
> constant ID values.
>

Indeed. Better to revise the original code as well.
