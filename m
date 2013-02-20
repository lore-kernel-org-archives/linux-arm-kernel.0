From: balbi@ti.com (Felipe Balbi)
Date: Wed, 20 Feb 2013 17:29:40 +0200
Subject: [PATCH 1/8] ARM: OMAP5: Update SOC id detection code for ES2
In-Reply-To: <1361374034-21831-2-git-send-email-santosh.shilimkar@ti.com>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
 <1361374034-21831-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130220152940.GE16652@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 20, 2013 at 08:57:07PM +0530, Santosh Shilimkar wrote:
>  	case 0xb998:
>  		switch (rev) {
>  		case 0:
> -		default:
>  			omap_revision = OMAP5432_REV_ES1_0;
> +			break;
> +		case 1:
> +			omap_revision = OMAP5432_REV_ES2_0;
> +			break;
> +		default:
> +			omap_revision = OMAP5432_REV_ES2_0;

no need for the duplication:

+		case 1:
+		default:
+			omap_revision = OMAP5432_REV_ES2_0;

will work just fine.

>  		}
>  		break;
>  
>  	default:
>  		/* Unknown default to latest silicon rev as default*/
> -		omap_revision = OMAP5430_REV_ES1_0;
> +		omap_revision = OMAP5430_REV_ES2_0;

how about we default to 0xffffffff ? That's the highest possible
version, just not sure if our revision macros can cope with it.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130220/9913146e/attachment.sig>
