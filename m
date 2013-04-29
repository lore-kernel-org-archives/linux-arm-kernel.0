From: balbi@ti.com (Felipe Balbi)
Date: Mon, 29 Apr 2013 21:24:41 +0300
Subject: [V9 PATCH 01/12] usb: phy: protect phy init and shutdown for
 mutiple deivces
In-Reply-To: <1366784606-1813-2-git-send-email-chao.xie@marvell.com>
References: <1366784606-1813-1-git-send-email-chao.xie@marvell.com>
 <1366784606-1813-2-git-send-email-chao.xie@marvell.com>
Message-ID: <20130429182441.GA1632@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 02:23:15AM -0400, Chao Xie wrote:
> diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
> index 6b5978f..98d7e60 100644
> --- a/include/linux/usb/phy.h
> +++ b/include/linux/usb/phy.h
> @@ -87,6 +87,14 @@ struct usb_phy {
>  	/* to support controllers that have multiple transceivers */
>  	struct list_head	head;
>  
> +	/*
> +	 * PHY may be shared by multiple devices.
> +	 * mutex and refcount are used to make sure PHY only initialize or
> +	 * shutdown once.

bad grammar in this sentence.

> +	 */
> +	struct mutex		phy_mutex;
> +	unsigned int		refcount;

why don't you use an atomic_t ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130429/810dec42/attachment.sig>
