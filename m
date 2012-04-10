From: balbi@ti.com (Felipe Balbi)
Date: Tue, 10 Apr 2012 12:24:43 +0300
Subject: [PATCH RESEND] Input: omap-keypad: dynamically handle register
 offsets
In-Reply-To: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
References: <1333430546-23454-1-git-send-email-sourav.poddar@ti.com>
Message-ID: <20120410092441.GB20616@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2012 at 10:52:26AM +0530, Sourav Poddar wrote:
> +static int kbd_write_irqstatus(struct omap4_keypad *keypad_data,
> +						u32 offset, u32 value)
> +{
> +	return __raw_writel(value, keypad_data->base + offset);
> +}
> +
> +static int kbd_write_irqenable(struct omap4_keypad *keypad_data,
> +						u32 offset, u32 value)
> +{
> +	return __raw_writel(value, keypad_data->base + offset);
> +}

if this only writes to irqenable, why do you pass offset as an argument?
likewise for irqstatus.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120410/8f295da2/attachment-0001.sig>
