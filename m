From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 16 Jan 2015 13:13:14 -0700
Subject: [PATCH] coresight: fix the debug AMBA bus name
In-Reply-To: <1421315385-79209-1-git-send-email-xiakaixu@huawei.com>
References: <1421315385-79209-1-git-send-email-xiakaixu@huawei.com>
Message-ID: <CANLsYkwxny2_YiPrDOJ1OYeUYqSB5gc3rSe9LHvjMmTNrz9RDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2015 at 02:49, Kaixu Xia <xiakaixu@huawei.com> wrote:
> The right debug AMBA bus name should be APB(Advanced Peripheral Bus),
> so just fix it.
>
> Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
> ---
>  Documentation/trace/coresight.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
> index bba7dbf..0236155 100644
> --- a/Documentation/trace/coresight.txt
> +++ b/Documentation/trace/coresight.txt
> @@ -46,7 +46,7 @@ At typical coresight system would look like this:
>    | |   .        | !   | |   .        | !      | !        .   |      | SWD/
>    | |   .        | !   | |   .        | !      | !        .   |      | JTAG
>    *****************************************************************<-|
> - *************************** AMBA Debug ABP ************************
> + *************************** AMBA Debug APB ************************
>    *****************************************************************
>     |    .          !         .          !        !        .    |
>     |    .          *         .          *        *        .    |
> @@ -79,7 +79,7 @@ At typical coresight system would look like this:
>            To trace port                       TPIU= Trace Port Interface Unit
>                                                SWD = Serial Wire Debug
>
> -While on target configuration of the components is done via the ABP bus,
> +While on target configuration of the components is done via the APB bus,
>  all trace data are carried out-of-band on the ATB bus.  The CTM provides
>  a way to aggregate and distribute signals between CoreSight components.
>
> --
> 1.8.5.5
>

Apply - thanks.
