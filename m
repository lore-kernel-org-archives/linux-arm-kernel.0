From: olof@lixom.net (Olof Johansson)
Date: Thu, 1 Aug 2013 13:31:09 -0700
Subject: [PATCH V2 3/3] ethernet: Convert mac address uses of 6 to ETH_ALEN
In-Reply-To: <4170130535e4ea14c66f8510042577be21941f4d.1375387593.git.joe@perches.com>
References: <cover.1375387593.git.joe@perches.com>
 <4170130535e4ea14c66f8510042577be21941f4d.1375387593.git.joe@perches.com>
Message-ID: <CAOesGMhmxJTDjcPeD4b1FvRsbP8df369F01SQBK6dk4nXmRGjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 1, 2013 at 1:14 PM, Joe Perches <joe@perches.com> wrote:

> diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.h b/drivers/net/ethernet/pasemi/pasemi_mac.h
> index e2f4efa..649fdb4 100644
> --- a/drivers/net/ethernet/pasemi/pasemi_mac.h
> +++ b/drivers/net/ethernet/pasemi/pasemi_mac.h
> @@ -79,11 +79,11 @@ struct pasemi_mac {
>         int             last_cs;
>         int             num_cs;
>         u32             dma_if;
> -       u8              type;
>  #define MAC_TYPE_GMAC  1
>  #define MAC_TYPE_XAUI  2
>
> -       u8              mac_addr[6];
> +       u8              mac_addr[ETH_ALEN];
> +       u8              type;

Just promote 'type' to u32 instead, saves you from moving the #defines
down, etc, etc.


-Olof
