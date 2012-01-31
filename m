From: jwjstone@fastmail.fm (Jack Stone)
Date: Tue, 31 Jan 2012 17:58:10 +0000
Subject: [PATCH 2/2] remoteproc: s/big switch/lookup table/
In-Reply-To: <1328028762-28352-2-git-send-email-ohad@wizery.com>
References: <1328028762-28352-1-git-send-email-ohad@wizery.com>
 <1328028762-28352-2-git-send-email-ohad@wizery.com>
Message-ID: <4F282BB2.6080604@fastmail.fm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/01/12 16:52, Ohad Ben-Cohen wrote:
> +/*
> + * A lookup table for resource handlers. Always keep in sync with
> + * enum fw_resource_type.
> + */
> +static rproc_handle_resource_t rproc_handle_rsc[] = {
> +	rproc_handle_carveout,	/* RSC_CARVEOUT */
> +	rproc_handle_devmem,	/* RSC_DEVMEM */
> +	rproc_handle_trace,	/* RSC_TRACE */
> +	rproc_handle_vring,	/* RSC_VRING */
> +	NULL, /* RSC_VIRTIO_DEV is handled early upon registration */
> +};
> +

You could change this to

[RSC_CARVEOUT] = rproc_handle_carveout,

Then you would be safe against renumbering and would only need to worry
about addition (which your RSC_LAST check copes with).

Thanks,

Jack
