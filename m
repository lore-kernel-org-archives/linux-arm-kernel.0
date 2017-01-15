From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 15 Jan 2017 13:26:52 +0100
Subject: [PATCH 3/4] iio: adc: add a driver for the SAR ADC found in
 Amlogic Meson SoCs
In-Reply-To: <20170111174334.24343-4-martin.blumenstingl@googlemail.com>
References: <20170111174334.24343-1-martin.blumenstingl@googlemail.com>
 <20170111174334.24343-4-martin.blumenstingl@googlemail.com>
Message-ID: <0bfa97d1-2ee3-9dd9-dce3-593e93771f03@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 06:43 PM, Martin Blumenstingl wrote:
> +	indio_dev->name = dev_name(&pdev->dev);

The name is supposed to be the type of the device, e.g. part name, not the
name of parent device instance. E.g. meson-gxbb-saradc or meson-gxl-saradc
in this case.
