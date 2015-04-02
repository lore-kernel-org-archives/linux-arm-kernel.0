From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Apr 2015 17:02:53 +0100
Subject: [PATCH 1/3] mfd: ucb1x00: add irq field to the platform data
In-Reply-To: <1427989307-1805-1-git-send-email-dbaryshkov@gmail.com>
References: <1427989307-1805-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150402160252.GO24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just like has already been pointed out on the list once today, we need
much better commit descriptions than this.

The code has been perfectly happy to auto-detect the IRQ for over ten
years.  Why do we suddenly need to change it now?  What's the
justification for this change.

Or is this just a case of "because we can" and you happen to have a
different opinion on how stuff should be done from how it's been
successfully done for the last ten years?

On Thu, Apr 02, 2015 at 06:41:45PM +0300, Dmitry Eremin-Solenikov wrote:
> To allow boards to specify the irq that is used by UCB1x00 chip, add irq
> field to the platform data structure.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  include/linux/mfd/ucb1x00.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/mfd/ucb1x00.h b/include/linux/mfd/ucb1x00.h
> index e1345ff..9a2dacb 100644
> --- a/include/linux/mfd/ucb1x00.h
> +++ b/include/linux/mfd/ucb1x00.h
> @@ -118,6 +118,7 @@ struct ucb1x00_plat_data {
>  	unsigned		irq_base;
>  	int			gpio_base;
>  	unsigned		can_wakeup;
> +	int			irq;
>  };
>  
>  struct ucb1x00 {
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
