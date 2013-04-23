From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 23 Apr 2013 15:11:33 +0200
Subject: RFC: [PATCH] clocksource: tcb: fix min_delta calculation
In-Reply-To: <1366722524-25991-1-git-send-email-mkl@pengutronix.de>
References: <517687AB.1040309@pengutronix.de>
 <1366722524-25991-1-git-send-email-mkl@pengutronix.de>
Message-ID: <51768885.4080301@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2013 03:08 PM, Marc Kleine-Budde wrote:
> The commit
> 
>     77cc982 clocksource: use clockevents_config_and_register() where possible
> 
> switches from manually calculating min_delta_ns (and others) and
> clockevents_register_device() to automatic calculation via
> clockevents_config_and_register(). During this conversation the "+ 1" in
> 
>     min_delta_ns = clockevent_delta2ns(1, &clkevt.clkevt) + 1;
> 
> was lost. This leads to problems with schedule_delayed_work() with a delay of
> "1". Resulting in the work not scheduled in time.
> 
> This patch fixes the problem by increasing the min_delta to "2" ticks.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

The problem appears on at91sam9263. This patch successfully fixes the
problem and applies to current linus/master (post v3.9-rc8).

regards,
Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130423/84a18667/attachment.sig>
