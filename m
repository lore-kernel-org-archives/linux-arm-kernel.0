From: jic23@jic23.retrosnub.co.uk (Jonathan Cameron)
Date: Mon, 16 Nov 2015 06:54:43 +0000
Subject: [PATCH] IIO: adc: xilinx-xadc-core.c: constify
 iio_buffer_setup_ops structure
In-Reply-To: <1447629111-6400-1-git-send-email-nizamhaider786@gmail.com>
References: <1447629111-6400-1-git-send-email-nizamhaider786@gmail.com>
Message-ID: <E5B479B9-0B4F-4183-A850-3E7DBC260D09@jic23.retrosnub.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15 November 2015 23:11:51 GMT+00:00, Nizam Haider <nizamhaider786@gmail.com> wrote:
>structure iio_buffer_setup_ops is never modified, so declare it as
>const.
>
>Signed-off-by: Nizam Haider <nijamh@cdac.in>
Sometimes it feels like there is something in the air...

Julia Lawal posted a patch for this yesterday.

Thanks

Jonathan
>---
> drivers/iio/adc/xilinx-xadc-core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/iio/adc/xilinx-xadc-core.c
>b/drivers/iio/adc/xilinx-xadc-core.c
>index 0370624..c2b5f10 100644
>--- a/drivers/iio/adc/xilinx-xadc-core.c
>+++ b/drivers/iio/adc/xilinx-xadc-core.c
>@@ -803,7 +803,7 @@ err:
> 	return ret;
> }
> 
>-static struct iio_buffer_setup_ops xadc_buffer_ops = {
>+static const struct iio_buffer_setup_ops xadc_buffer_ops = {
> 	.preenable = &xadc_preenable,
> 	.postenable = &iio_triggered_buffer_postenable,
> 	.predisable = &iio_triggered_buffer_predisable,

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
