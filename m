From: john.stultz@linaro.org (John Stultz)
Date: Wed, 23 Mar 2011 14:43:00 -0700
Subject: [PATCH V12 3/4] ptp: Added a clock driver for the IXP46x.
In-Reply-To: <cd6ddff0dcca60ac88b35660505d7bf54ad32405.1298878618.git.richard.cochran@omicron.at>
References: <cover.1298878618.git.richard.cochran@omicron.at>
	<cd6ddff0dcca60ac88b35660505d7bf54ad32405.1298878618.git.richard.cochran@omicron.at>
Message-ID: <1300916580.848.51.camel@work-vm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-02-28 at 08:58 +0100, Richard Cochran wrote:
> This patch adds a driver for the hardware time stamping unit found on the
> IXP465. The basic clock operations and an external trigger are implemented.
> 
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
> Acked-by: John Stultz <johnstul@us.ibm.com>

My ack is still fine, but found a few more nits to consider on another
pass... 


> +static int match(struct sk_buff *skb, u16 uid_hi, u32 uid_lo, u16 seq)
[snip]
> +static void do_rx_timestamp(struct port *port, struct sk_buff *skb)
[snip]
> +static u64 sys_time_read(struct ixp46x_ts_regs *regs)
[snip]
> +static void sys_time_write(struct ixp46x_ts_regs *regs, u64 ns)

I know these are static, but these function names are sort of generic
names, and make grep/cscoping for similar sounding functions a little
noisy. 

Maybe add a ipx_ prefix just to be more obvious?

thanks
-john
