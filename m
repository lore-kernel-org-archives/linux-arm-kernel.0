From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Nov 2017 17:18:01 +0000
Subject: [PATCH v16 12/13] arm, tile: turn off timer tick for
 oneshot_stopped state
In-Reply-To: <1509728692-10460-13-git-send-email-cmetcalf@mellanox.com>
References: <1509728692-10460-1-git-send-email-cmetcalf@mellanox.com>
 <1509728692-10460-13-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20171103171801.xzxyypt3axyawu7l@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Fri, Nov 03, 2017 at 01:04:51PM -0400, Chris Metcalf wrote:
> diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
> index fd4b7f684bd0..61ea7f907c56 100644
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -722,6 +722,8 @@ static void __arch_timer_setup(unsigned type,
>  		}
>  	}
>  
> +	clk->set_state_oneshot_stopped = clk->set_state_shutdown;

AFAICT, we've set up this callback since commit:

  cf8c5009ee37d25c ("clockevents/drivers/arm_arch_timer: Implement ->set_state_oneshot_stopped()")

... so I don't beleive this is necessary, and I think this change can be
dropped.

Thanks,
Mark.
