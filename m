From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 30 Jul 2013 17:26:57 +0900
Subject: [PATCH] ARM: shmobile: lager: do not annotate gpio_buttons as
 __initdata
In-Reply-To: <1374829772-10939-1-git-send-email-horms+renesas@verge.net.au>
References: <1374829772-10939-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CANqRtoRUc1r_5=4HHa19ZCr71r1jv5AwZQ39Jv7eFNOUomtjag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 6:09 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> When the gpio-keys device is registered using
> platform_device_register_data() the platform data argument,
> lager_keys_pdata is duplicated and thus should be marked as __initdata
> to avoid wasting memory. However, this is not true of gpio_buttons,
> a reference to it rather than its value is duplicated when lager_keys_pdata
> is duplicated.
>
> This avoids accessing freed memory if gpio-key events occur
> after unused kernel memory is freed late in the kernel's boot.
>
> This but was added when support for gpio-keys was added to lager
> in c3842e4fcbb7664276443b79187b7808c2e80a35
> ("ARM: shmobile: lager: support GPIO switches") which was included
> in v3.11-rc1.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
>
> * Noticed when adding gpio-keys support to ape6evm
> * Compile tested only

I just got around to test this patch on a Lager board, works well. Thanks!

Tested-by: Magnus Damm <damm@opensource.se>
