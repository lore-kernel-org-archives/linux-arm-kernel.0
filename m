From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 07 Jun 2015 17:49:26 +0100
Subject: [PATCH v2 2/2] iio: adc: xilinx-xadc: Add label as an optional
 argument for aux channels
In-Reply-To: <1432135352-29848-2-git-send-email-xander.huff@ni.com>
References: <555B78A3.2030202@metafoo.de>
 <1432135352-29848-1-git-send-email-xander.huff@ni.com>
 <1432135352-29848-2-git-send-email-xander.huff@ni.com>
Message-ID: <55747616.1010901@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/15 16:22, Xander Huff wrote:
> To better facilitate user-mode access to optional aux channels, allow
> device trees to specify a custom label for defined channels.
> 
> Signed-off-by: Xander Huff <xander.huff@ni.com>
> Reviewed-by: Joe Hershberger <joe.hershberger@ni.com>
> Reviewed-by: Josh Cartwright <joshc@ni.com>
> ---
>  drivers/iio/adc/xilinx-xadc-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index ce93bd8..bda4241 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1119,6 +1119,9 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, struct device_node *np,
>  			if (ret || reg > 16)
>  				continue;
>  
> +			of_property_read_string(child, "label",
> +						&chan->extend_name);
> +
>  			if (of_property_read_bool(child, "xlnx,bipolar"))
>  				chan->scan_type.sign = 's';
>  
> 
I think what Lars was suggesting was a change to the IIO side of this rather than
just changing the device tree binding.  Perhaps an additional per channel attribute
called _label which would allow for board specific labelling?
