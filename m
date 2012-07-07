From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sat, 7 Jul 2012 13:53:46 +0300
Subject: [PATCH 2/3] hwspinlock/core: add notes on lock element in 'struct
 hwspinlock'
In-Reply-To: <4FF66FFE.2020803@renesas.com>
References: <4FF66FBD.5090601@renesas.com> <4FF66FFE.2020803@renesas.com>
Message-ID: <CAK=WgbYN5J_QDKL8YP1hk17b7A8EOQbOy65aSihNjRZ88LOhHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shinya,

On Fri, Jul 6, 2012 at 7:56 AM, Shinya Kuribayashi
<shinya.kuribayashi.px@renesas.com> wrote:
> 'lock' must be placed at the end of struct hwspinlock_device because
> we're doing 'hwlock = &bank->lock[0]' to get a pointer to the first
> 'struct hwspinlock' instance.

I don't mind taking this one, but it will be nicer if the commit log
would describe the patch itself and its motivation (even if it's
trivial like this one).

Thanks,
Ohad.

>
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> ---
>  drivers/hwspinlock/hwspinlock_internal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwspinlock/hwspinlock_internal.h b/drivers/hwspinlock/hwspinlock_internal.h
> index d26f78b..c60318c 100644
> --- a/drivers/hwspinlock/hwspinlock_internal.h
> +++ b/drivers/hwspinlock/hwspinlock_internal.h
> @@ -57,7 +57,8 @@ struct hwspinlock {
>   * @ops: platform-specific hwspinlock handlers
>   * @base_id: id index of the first lock in this device
>   * @num_locks: number of locks in this device
> - * @lock: dynamically allocated array of 'struct hwspinlock'
> + * @lock: dynamically allocated array of 'struct hwspinlock' (must be placed
> + *       at the end of the hwspinlock_device)
>   */
>  struct hwspinlock_device {
>         struct device *dev;
> --
> 1.7.11.1
>
