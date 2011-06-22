From: will.newton@gmail.com (Will Newton)
Date: Wed, 22 Jun 2011 11:05:41 +0100
Subject: [RFC 2/8] remoteproc: add omap implementation
In-Reply-To: <1308640714-17961-3-git-send-email-ohad@wizery.com>
References: <1308640714-17961-1-git-send-email-ohad@wizery.com>
	<1308640714-17961-3-git-send-email-ohad@wizery.com>
Message-ID: <BANLkTimAf9EqSX-yHh_0RPaeewndOyNUYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 8:18 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:

> +/* bootaddr isn't needed for the dual M3's */
> +static inline int omap_rproc_start(struct rproc *rproc, u64 bootaddr)

> +static inline int omap_rproc_stop(struct rproc *rproc)

These two functions don't need to be inline as far as I can see.

> +static struct rproc_ops omap_rproc_ops = {
> + ? ? ? .start = omap_rproc_start,
> + ? ? ? .stop = omap_rproc_stop,
> +};
