From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 09 Mar 2016 08:40:45 +0000
Subject: [PATCH] bus: arm-ccn: Fix cpu notifier priority
In-Reply-To: <1457439273-5998-1-git-send-email-jglauber@cavium.com>
References: <1457439273-5998-1-git-send-email-jglauber@cavium.com>
Message-ID: <1457512845.22102.113.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-03-08 at 13:14 +0100, Jan Glauber wrote:
> Fix cpu priority of notifier block that was erroneously set to
> return value of next statement.
> 
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> ---
>  drivers/bus/arm-ccn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
> index 7082c72..d4a939e 100644
> --- a/drivers/bus/arm-ccn.c
> +++ b/drivers/bus/arm-ccn.c
> @@ -1271,7 +1271,7 @@ static int arm_ccn_pmu_init(struct arm_ccn
> *ccn)
>  	 * picked to have a chance to migrate events before perf is
> notified.
>  	 */
>  	ccn->dt.cpu_nb.notifier_call = arm_ccn_pmu_cpu_notifier;
> -	ccn->dt.cpu_nb.priority = CPU_PRI_PERF + 1,
> +	ccn->dt.cpu_nb.priority = CPU_PRI_PERF + 1;
>  	err = register_cpu_notifier(&ccn->dt.cpu_nb);
>  	if (err)
>  		goto error_cpu_notifier;

Damn, of course! I have never made (or heard about) such a typo before 
- I wish the compiler warned about it :-(

By all means:

Acked-by: Pawel Moll <pawel.moll@arm.com>
Cc: <stable@vger.kernel.org> # 4.2+

Arnd, would you be still able to pick it up in this cycle?

Thanks Both!

Pawe?
