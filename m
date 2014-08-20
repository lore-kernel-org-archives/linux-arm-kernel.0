From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Wed, 20 Aug 2014 16:24:04 +0200
Subject: [PATCH v4 2/2] net: moxa: replace build_skb() with
 netdev_alloc_skb_ip_align() / memcpy()
In-Reply-To: <1408473119.5604.4.camel@edumazet-glaptop2.roam.corp.google.com>
References: <1408459784-9385-1-git-send-email-jonas.jensen@gmail.com>
 <1408459784-9385-2-git-send-email-jonas.jensen@gmail.com>
 <1408473119.5604.4.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <CACmBeS0MB+K_30vLACZJ8LqzmXejGQ=PP_t+gFpmke1e5yub9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 August 2014 20:31, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> Instead of :
>
> priv->rx_buf_size = RX_BUF_SIZE +
>                 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>
> I think rx_buf_size can now be RX_BUF_SIZE

You're right, that's now a remnant, see update in v5.


> Another point is that priv->stats seems not needed, as ndev->stats could
> be used instead (and remove moxart_mac_get_stats())

I will fix that. I can add it to patches adding support for ethtool /
stats and PHY.

I think I'm supposed to post those closer to the merge window, which
would keep this set about bug fixes only.


Regards,


   Jonas
