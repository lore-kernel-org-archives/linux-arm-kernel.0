From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 18 Aug 2016 18:16:34 +0100
Subject: [PATCH 02/13] scpi: Add alternative legacy structures and macros
In-Reply-To: <1471515066-3626-3-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
 <1471515066-3626-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <2b345fec-4dbd-2144-cd34-d8451bb314c0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/08/16 11:10, Neil Armstrong wrote:
> In order to support the legacy SCPI protocol variant, add back the structures
> and macros that varies against the final specification.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> I checked against Amlogic implementation documentation and on-device, the channel selection
> via legacy_scpi_get_chan() is needed and fails without it.
> The sender_id is not needed so it was dropped.
>
>  drivers/firmware/arm_scpi.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
> index 403783a..0bb6134 100644
> --- a/drivers/firmware/arm_scpi.c
> +++ b/drivers/firmware/arm_scpi.c

[...]

> @@ -183,6 +224,11 @@ struct scpi_shared_mem {
>  	u8 payload[0];
>  } __packed;
>
> +struct legacy_scpi_shared_mem {
> +	__le32 status;
> +	u8 payload[0];
> +} __packed;
> +
>  struct scp_capabilities {
>  	__le32 protocol_version;
>  	__le32 event_version;
> @@ -208,6 +254,12 @@ struct clk_set_value {
>  	__le32 rate;
>  } __packed;
>
> +struct legacy_clk_set_value {
> +	__le32 rate;
> +	__le16 id;
> +	__le16 reserved;
> +} __packed;
> +
>  struct dvfs_info {
>  	__le32 header;
>  	struct {
> @@ -237,6 +289,10 @@ struct sensor_value {
>  	__le32 hi_val;
>  } __packed;
>
> +struct legacy_sensor_value {
> +	__le32 val;
> +} __packed;
> +

Not required, new one is backward compatible. Otherwise this patch looks
fine.

-- 
Regards,
Sudeep
