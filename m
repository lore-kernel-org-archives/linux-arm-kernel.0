From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 24 Aug 2017 17:50:11 +0100
Subject: [PATCH 2/3] pci: designware: add separate driver for the MSI part
 of the RC
In-Reply-To: <e1f5e20d-929f-db8d-1c60-181698e678f0@arm.com>
References: <20170821192907.8695-1-ard.biesheuvel@linaro.org>
 <20170821192907.8695-3-ard.biesheuvel@linaro.org>
 <e1f5e20d-929f-db8d-1c60-181698e678f0@arm.com>
Message-ID: <CAKv+Gu-mxLnnrZ58PR1hfcBScddewQ8rT77b0fRDnHVViu2WiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2017 at 17:48, Robin Murphy <robin.murphy@arm.com> wrote:
> Hi Ard,
>
> On 21/08/17 20:29, Ard Biesheuvel wrote:
> [...]
>> +static int dw_pcie_msi_probe(struct platform_device *pdev)
>> +{
>> +     struct fwnode_handle *fwnode = of_node_to_fwnode(pdev->dev.of_node);
>
> Mini-nit: since fairly recently (f94277af03ea) dev->fwnode should
> already be set appropriately by of_platform_device_create(), so you
> should be able to make this entirely firmware-agnostic if you like.
>

Thanks for pointing that out. I'm not sure yet what it means exactly,
but I'm sure I will figure it out :-)
