From: balbi@ti.com (Felipe Balbi)
Date: Mon, 2 Jul 2012 14:59:05 +0300
Subject: [PATCHv3 17/17] i2c: omap: get rid of the "complete" label
In-Reply-To: <1340964817-8599-18-git-send-email-shubhrajyoti@ti.com>
References: <1340964817-8599-1-git-send-email-shubhrajyoti@ti.com>
 <1340964817-8599-18-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120702115904.GE2730@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 29, 2012 at 03:43:37PM +0530, Shubhrajyoti D wrote:
> @@ -962,7 +972,7 @@ complete:
>  			ret = omap_i2c_transmit_data(dev, num_bytes, true);
>  			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);

this isn't needed anymore. please remove.

>  			if (ret < 0)
> -				goto complete;
> +				goto out;
>  
>  			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_XDR);
>  			continue;
> @@ -978,7 +988,7 @@ complete:
>  			ret = omap_i2c_transmit_data(dev, num_bytes, false);
>  			stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);

this isn't needed anymore. please remove.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120702/5cae2edd/attachment.sig>
