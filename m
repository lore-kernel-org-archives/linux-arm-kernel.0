From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 20 Jul 2015 18:26:06 +0100
Subject: [Xen-devel] [PATCH v2 17/20] net/xen-netfront: Make it running
 on 64KB page granularity
In-Reply-To: <1436474552-31789-18-git-send-email-julien.grall@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-18-git-send-email-julien.grall@citrix.com>
Message-ID: <55AD2F2E.9090204@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/07/15 21:42, Julien Grall wrote:
> +static void xennet_make_one_txreq(unsigned long mfn, unsigned int offset,
> +				  unsigned int *len, void *data)
> +{
> +	struct xennet_gnttab_make_txreq *info = data;
> +
> +	info->tx->flags |= XEN_NETTXF_more_data;
> +	skb_get(info->skb);
> +	xennet_make_one_txreq(mfn, offset, len, data);

This should be xennet_tx_setup_grant rather than calling itself. I did
the mistake while cleaning up the code sorry.

Regards,

-- 
Julien Grall
