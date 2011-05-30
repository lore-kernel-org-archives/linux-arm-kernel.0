From: vapier@gentoo.org (Mike Frysinger)
Date: Mon, 30 May 2011 01:05:08 -0400
Subject: [PATCH 2/4] clk: Implement clk_set_rate
In-Reply-To: <1305876469.326620.351525457111.2.gpush@pororo>
References: <1305876469.326620.351525457111.2.gpush@pororo>
Message-ID: <201105300105.10258.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 20, 2011 03:27:49 Jeremy Kerr wrote:
>  int clk_set_rate(struct clk *clk, unsigned long rate)
>  {
> -	/* not yet implemented */
> -	return -ENOSYS;
> +	unsigned long parent_rate, new_rate;
> +	int ret;
> +
> +	if (!clk->ops->set_rate)
> +		return -ENOSYS;

i thought ENOSYS is only for syscalls.  shouldnt this be ENODEV or perhaps 
EOPNOTSUPP ?
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110530/64fac7f1/attachment.sig>
