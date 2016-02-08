From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 8 Feb 2016 16:30:37 +0300
Subject: [PATCH 5/6] net: thunderx: bgx: Add log message when setting mac
 address
In-Reply-To: <1454933272-45005-6-git-send-email-sunil.kovvuri@gmail.com>
References: <1454933272-45005-1-git-send-email-sunil.kovvuri@gmail.com>
 <1454933272-45005-6-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <56B8987D.7000901@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 2/8/2016 3:07 PM, sunil.kovvuri at gmail.com wrote:

> From: Robert Richter <rrichter@cavium.com>
>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
> ---
>   drivers/net/ethernet/cavium/thunder/thunder_bgx.c |   11 ++++++++---
>   1 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> index 111835b..cfee496 100644
> --- a/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
> +++ b/drivers/net/ethernet/cavium/thunder/thunder_bgx.c
[...]
> @@ -897,10 +898,13 @@ static int acpi_get_mac_address(struct acpi_device *adev, u8 *dst)
>   		goto out;
>
>   	if (!is_valid_ether_addr(mac)) {
> +		dev_warn(dev, "MAC address invalid: %pM\n", mac);

    dev_er(), maybe?

>   		ret = -EINVAL;
>   		goto out;
>   	}
>
> +	dev_info(dev, "MAC address set to: %pM\n", mac);
> +
>   	memcpy(dst, mac, ETH_ALEN);
>   out:
>   	return ret;
[...]

MBR, Sergei
