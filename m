From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sun, 15 Jan 2017 13:23:15 +0100
Subject: [PATCH v9 3/3] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <20161213143332.24988-4-quentin.schulz@free-electrons.com>
References: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
 <20161213143332.24988-4-quentin.schulz@free-electrons.com>
Message-ID: <64744012-d26a-2b85-b9d9-1ad1c4e2f84a@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/13/2016 03:33 PM, Quentin Schulz wrote:

> +	indio_dev->name = dev_name(&pdev->dev);

The name is supposed to be the type of the device, e.g. part name, not the
name of parent device instance. This could e.g. come from a name field in
the gpadc_data struct.
