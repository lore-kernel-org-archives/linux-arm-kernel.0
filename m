From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 2 Jan 2015 08:08:54 -0700
Subject: [PATCH] coresight: remove the unused macro CORESIGHT_DEBUGFS_ENTRY
In-Reply-To: <1419937657-35292-1-git-send-email-xiakaixu@huawei.com>
References: <1419937657-35292-1-git-send-email-xiakaixu@huawei.com>
Message-ID: <CANLsYky7DE2ej3vvk59p0bCX5B295sRKHpvrEfXVLvfr71jFxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 December 2014 at 04:07, Kaixu Xia <xiakaixu@huawei.com> wrote:
> From: Xia Kaixu <xiakaixu@huawei.com>
>
> Debugfs isn't used for coresight configuration, so the macro
> CORESIGHT_DEBUGFS_ENTRY is unnecessary, just remove it.
>
> Signed-off-by: Xia Kaixu <xiakaixu@huawei.com>
> ---
>  include/linux/coresight.h | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 5d3c543..7cbfecb 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -179,15 +179,6 @@ struct coresight_device {
>  #define sink_ops(csdev)                csdev->ops->sink_ops
>  #define link_ops(csdev)                csdev->ops->link_ops
>
> -#define CORESIGHT_DEBUGFS_ENTRY(__name, __entry_name,                  \
> -                                __mode, __get, __set, __fmt)           \
> -DEFINE_SIMPLE_ATTRIBUTE(__name ## _ops, __get, __set, __fmt);          \
> -static const struct coresight_ops_entry __name ## _entry = {           \
> -       .name = __entry_name,                                           \
> -       .mode = __mode,                                                 \
> -       .ops  = &__name ## _ops                                         \
> -}
> -
>  /**
>   * struct coresight_ops_sink - basic operations for a sink
>   * Operations available for sinks
> --
> 2.2.1
>

Applied - thanks.
