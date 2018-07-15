From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 15 Jul 2018 14:15:07 +0200
Subject: [PATCH v6 3/8] interconnect: Add debugfs support
In-Reply-To: <20180709155104.25528-4-georgi.djakov@linaro.org>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
 <20180709155104.25528-4-georgi.djakov@linaro.org>
Message-ID: <20180715121507.GA17794@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 09, 2018 at 06:50:59PM +0300, Georgi Djakov wrote:
> +static int __init icc_debugfs_init(void)
> +{
> +	struct dentry *file;
> +
> +	icc_debugfs_dir = debugfs_create_dir("interconnect", NULL);
> +	if (!icc_debugfs_dir) {
> +		pr_err("interconnect: error creating debugfs directory\n");
> +		return -ENODEV;
> +	}

You should never care about the return value of a debugfs call.  Just
ignore it and move on.

> +	file = debugfs_create_file("interconnect_summary", 0444,
> +				   icc_debugfs_dir, NULL, &icc_summary_fops);
> +	if (!file)
> +		return -ENODEV;

Again, do not check this.

Where do you remove this directory and file from the system when the
code shuts down?

thanks,

greg k-h
