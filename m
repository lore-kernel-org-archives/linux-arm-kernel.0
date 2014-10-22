From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Oct 2014 10:46:06 +0200
Subject: [PATCH V2 1/2] ARM: pxa: spitz: register spitz-audio device
In-Reply-To: <1413926133-3566-1-git-send-email-dbaryshkov@gmail.com>
References: <1413926133-3566-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1935279.fumFSz5CfW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 October 2014 01:15:32 Dmitry Eremin-Solenikov wrote:
> Register spitz-audio device to be used by ASoC driver.
> 
> [V2: Removed ifdefs around spitz_audio_init].
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> 

A more general note about your patch description above: when you
write about the changes between versions, put that below the ---
line under your Signed-off-by. Aside from that, your changelog
entry would actually benefit from more verbosity: explain what the
purpose of this is, not just what it does. 

>  /**************************************************************************
>  ****> 
> + * Audio devices
> +
> ***************************************************************************
> ***/ +static struct platform_device spitz_audio_device = {
> +       .name   = "spitz-audio",
> +       .id     = -1,
> +};
> +
> +static inline void spitz_audio_init(void)
> +{
> +       platform_device_register(&spitz_audio_device);
> +}+

I realize that the file has more of these, but it would be better
for a number of reasons to use 'platform_device_register_simple'
instead of platform_device_register. statically defining platform
devices (or any other device) is not recommended.

	Arnd
