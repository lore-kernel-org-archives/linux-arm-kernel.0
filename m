From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Mon, 8 Feb 2016 14:48:35 +0100
Subject: [PATCH 5/6] net: thunderx: bgx: Add log message when setting mac
 address
In-Reply-To: <56B8987D.7000901@cogentembedded.com>
References: <1454933272-45005-1-git-send-email-sunil.kovvuri@gmail.com>
 <1454933272-45005-6-git-send-email-sunil.kovvuri@gmail.com>
 <56B8987D.7000901@cogentembedded.com>
Message-ID: <20160208134835.GX24726@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.02.16 16:30:37, Sergei Shtylyov wrote:
> >@@ -897,10 +898,13 @@ static int acpi_get_mac_address(struct acpi_device *adev, u8 *dst)
> >  		goto out;
> >
> >  	if (!is_valid_ether_addr(mac)) {
> >+		dev_warn(dev, "MAC address invalid: %pM\n", mac);
> 
>    dev_er(), maybe?

Since the driver may continue, my choice was a warning only.

-Robert

> 
> >  		ret = -EINVAL;
> >  		goto out;
> >  	}
> >
> >+	dev_info(dev, "MAC address set to: %pM\n", mac);
> >+
> >  	memcpy(dst, mac, ETH_ALEN);
> >  out:
> >  	return ret;
> [...]
