From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Mar 2015 12:34:37 +0100
Subject: [PATCH 3/3] mailbox: Add support for ST's Mailbox IP
In-Reply-To: <1425379283-1567-4-git-send-email-lee.jones@linaro.org>
References: <1425379283-1567-1-git-send-email-lee.jones@linaro.org>
 <1425379283-1567-4-git-send-email-lee.jones@linaro.org>
Message-ID: <3926609.Ff6LCkuuMX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 March 2015 10:41:23 Lee Jones wrote:
> +
> +/*
> + * struct sti_mbox_msg - sti mailbox message description
> + * @dsize:             data payload size
> + * @pdata:             message data payload
> + */
> +struct sti_mbox_msg {
> +       u32             dsize;
> +       u8              *pdata;
> +};

As mentioned in another thread, we may just want to add a 'size'
argument to the message send function, and a default helper for
messages with size of 32 bits.

I don't think it's good to fragment this further by adding
an indirect message interface in a particular driver.

	Arnd
