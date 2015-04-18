From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 18 Apr 2015 10:55:50 +0200
Subject: [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
Message-ID: <20150418085550.GA29858@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 17, 2015 at 09:50:56AM +0200, Jens Wiklander wrote:
> +/**
> + * struct tee_cmd_data - Opaque command argument
> + * @buf_ptr:	[in] A __user pointer to a command buffer
> + * @buf_len:	[in] Length of the buffer above
> + *
> + * Opaque command data which is passed on to the specific driver. The command
> + * buffer doesn't have to reside in shared memory.
> + * Used as argument for TEE_IOC_CMD below.
> + */
> +struct tee_ioctl_cmd_data {
> +	uint64_t buf_ptr;
> +	uint64_t buf_len;
> +};

All structures that cross the user/kernel boundry must use the __
variant of variable names.  So for this one, it must be __u64.

Same for all of your ioctl structures.

thanks,

greg k-h
