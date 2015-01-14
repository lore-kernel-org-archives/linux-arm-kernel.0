From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Jan 2015 09:53:34 +0100
Subject: [PATCH net-next v13 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <1421217254-12008-4-git-send-email-dingtianhong@huawei.com>
References: <1421217254-12008-1-git-send-email-dingtianhong@huawei.com>
 <1421217254-12008-4-git-send-email-dingtianhong@huawei.com>
Message-ID: <3131780.HetDHI4Cfl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 January 2015 14:34:14 Ding Tianhong wrote:
> +#define HIP04_MAX_TX_COALESCE_USECS    200
> +#define HIP04_MIN_TX_COALESCE_USECS    100
> +#define HIP04_MAX_TX_COALESCE_FRAMES   200
> +#define HIP04_MIN_TX_COALESCE_FRAMES   100

It's not important, but in case you are creating another version of the
patch, maybe the allowed range can be extended somewhat. The example values
I picked when I sent my suggestion were really made up. It's great if
they work fine, but users might want to  tune this far more depending on
their workloads,  How about these

#define HIP04_MAX_TX_COALESCE_USECS    100000
#define HIP04_MIN_TX_COALESCE_USECS    1
#define HIP04_MAX_TX_COALESCE_FRAMES   (TX_DESC_NUM - 1)
#define HIP04_MIN_TX_COALESCE_FRAMES   1

	Arnd
