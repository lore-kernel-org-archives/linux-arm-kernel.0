From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 16 Oct 2009 19:35:42 +0100
Subject: [PATCH 5/6] mx31moboard: camera support
In-Reply-To: <1255599780-12948-6-git-send-email-valentin.longchamp@epfl.ch>
References: <1255599780-12948-1-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-2-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-3-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-4-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-5-git-send-email-valentin.longchamp@epfl.ch>
	<1255599780-12948-6-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <20091016183542.GA17849@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2009 at 11:42:59AM +0200, Valentin Longchamp wrote:
> +	buf = dma_alloc_coherent(NULL, buf_size, &dma_handle, GFP_KERNEL);
> +	if (!buf) {
> +		pr_err("%s: cannot allocate camera buffer-memory\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	memset(buf, 0, buf_size);

No need to memset memory returned from dma_alloc_coherent.
