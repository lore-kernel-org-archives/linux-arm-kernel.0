From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 29 May 2018 15:09:48 +0200
Subject: [patch v23 1/4] drivers: jtag: Add JTAG core driver
In-Reply-To: <1527594545-19870-2-git-send-email-oleksandrs@mellanox.com>
References: <1527594545-19870-1-git-send-email-oleksandrs@mellanox.com>
 <1527594545-19870-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <20180529130948.GC30119@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 02:49:02PM +0300, Oleksandr Shamray wrote:
> +static int jtag_release(struct inode *inode, struct file *file)
> +{
> +	return 0;
> +}

If you do not do anything, then there is no need to have this callback
at all, right?

> +/**
> + * enum jtag_endstate:
> + *
> + * @JTAG_STATE_IDLE: JTAG state machine IDLE state
> + * @JTAG_STATE_PAUSEIR: JTAG state machine PAUSE_IR state
> + * @JTAG_STATE_PAUSEDR: JTAG state machine PAUSE_DR state
> + */
> +enum jtag_endstate {
> +	JTAG_STATE_IDLE,
> +	JTAG_STATE_PAUSEIR,
> +	JTAG_STATE_PAUSEDR,

Be specific with these enums, set them to a value so you know all is
good.  Userspace C compilers can be funny at times.

Otherwise, looks really good, nice work.

greg k-h
