From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 21 Jun 2016 16:25:14 +0300
Subject: [PATCH net-next 16/19] net: hns: fix bug that alloc skb fail lead
 to port unavailable
In-Reply-To: <1466481399-70080-17-git-send-email-Yisen.Zhuang@huawei.com>
References: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
 <1466481399-70080-17-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <097b1147-3587-9579-0f94-f42be130773c@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 6/21/2016 6:56 AM, Yisen Zhuang wrote:

> From: Jun He <hjat2005@huawei.com>
>
> When hns_nic_poll_rx_skb alloc skb fail, it will break receive cycle and
> read new fbd_num to start new receive cycle. It recomputes cycle num is
> fbd_num minus clean_count, actually this cycle num is too big because
> it drop out receive cycle. It brings about the port unavailable.
>
> So we will goto out when alloc skb fail to fix this bug.
>
> Signed-off-by: Jun He <hjat2005@huawei.com>
> Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
> Signed-off-by: Yisen Zhuang <Yisen.Zhuang@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns/hns_enet.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> index f49246d..c0ce37b 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> @@ -768,10 +768,10 @@ recv:
>  			clean_count = 0;
>  		}
>
> -		/* poll one pkg*/
> +		/* poll one pkt*/

    How about adding a space before */?

[...]

MBR, Sergei
