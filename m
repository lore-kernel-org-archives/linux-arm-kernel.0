From: joe@perches.com (Joe Perches)
Date: Tue, 22 Jul 2014 06:33:58 -0700
Subject: [PATCH 09/19] mfd: ezx-pcap: Repair coding style errors picked
 up with checkpatch
In-Reply-To: <1406027485-15657-10-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
 <1406027485-15657-10-git-send-email-lee.jones@linaro.org>
Message-ID: <1406036038.30871.19.camel@joe-AO725>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-07-22 at 12:11 +0100, Lee Jones wrote:
> This is part of an effort to clean-up the MFD subsystem.
> 
> WARNING: Missing a blank line after declarations
> +       u32 flags;
> +       void (*callback)(void *, u16[]);

False positive from an old version of checkpatch.

The one in -next doesn't emit this as it's
simply a function pointer declaration.

> diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
[]
> @@ -25,8 +25,9 @@ struct pcap_adc_request {
>  	u8 bank;
>  	u8 ch[2];
>  	u32 flags;
> -	void (*callback)(void *, u16[]);
>  	void *data;
> +
> +	void (*callback)(void *, u16[]);
>  };
