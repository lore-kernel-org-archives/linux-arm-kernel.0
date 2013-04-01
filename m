From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 1 Apr 2013 14:46:13 +0100
Subject: [PATCH v7 06/14] spi/spi-atmel: add flag to controller data for
 lock operations
In-Reply-To: <1363679163-3897-1-git-send-email-wenyou.yang@atmel.com>
References: <1363678866-3567-1-git-send-email-wenyou.yang@atmel.com>
 <1363679163-3897-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20130401134613.GY18636@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 03:46:03PM +0800, Wenyou Yang wrote:

> +static void atmel_spi_lock(struct atmel_spi *as)
> +{
> +		spin_lock_irqsave(&as->lock, as->flags);
> +}

Coding style.

> -	spin_unlock(&as->lock);
> +	atmel_spi_unlock(as);
>  	msg->complete(msg->context);
> -	spin_lock(&as->lock);
> +	atmel_spi_lock(as);

This replaces non-irqsave versions with irqsave versions of the lock.
Is this safe/correct?  If it is I'd have expected some sort of mention
of it in the commit log.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130401/435cb807/attachment.sig>
