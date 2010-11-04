From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 04 Nov 2010 12:30:02 -0700
Subject: [PATCHv2 2/3] ARM: Allow machines to override __delay()
In-Reply-To: <1288300770-18350-3-git-send-email-sboyd@codeaurora.org>
References: <1288300770-18350-1-git-send-email-sboyd@codeaurora.org>
	<1288300770-18350-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <1288899002.21823.3.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-10-28 at 14:19 -0700, Stephen Boyd wrote:
> +
> +static void (*delay_fn)(unsigned long) = delay_loop;
> +
> +void set_delay_fn(void (*fn)(unsigned long))
> +{
> +       delay_fn = fn;
> +}

This needs to be a static inline in the header file.

> +/*
> + * loops = usecs * HZ * loops_per_jiffy / 1000000
> + */
> +void __delay(unsigned long loops)
> +{
> +       delay_fn(loops);
> +}
>  EXPORT_SYMBOL(__delay);

Can we make this static inline also? I'm sure about the module issues..

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
