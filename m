From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 12 Aug 2015 15:13:56 -0700
Subject: [PATCH 1/2] Add a matching set of device_ functions for
 determining mac/phy
In-Reply-To: <1439417187-21411-2-git-send-email-jeremy.linton@arm.com>
References: <1439417187-21411-1-git-send-email-jeremy.linton@arm.com>
 <1439417187-21411-2-git-send-email-jeremy.linton@arm.com>
Message-ID: <55CBC524.4070101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/15 15:06, Jeremy Linton wrote:
> OF has some helper functions for parsing MAC and PHY settings.
> In cases where the platform is providing this information rather
> than the device itself, there needs to be similar functions for ACPI.
> 
> These functions are slightly modified versions of the ones in
> of_net which can use information provided via DT or ACPI.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---

[snip]

> +
> +static void *device_get_mac_addr(struct device *dev,
> +				 const char *name, char *addr,
> +				 int alen)
> +{
> +	int ret = device_property_read_u8_array(dev, name, addr, alen);
> +
> +	if (ret == 0 && is_valid_ether_addr(addr))
> +		return addr;
> +	return NULL;

The DT counterpart has an additional check on the properly length to be
ETH_ALEN, you might want to have such check here for consistency and
correctness.

Other than that, this looks good to me.
-- 
Florian
