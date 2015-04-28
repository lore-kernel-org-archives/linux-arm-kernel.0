From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Apr 2015 14:28:26 +0200
Subject: [PATCH 01/11] coresight-etm4x: Adding CoreSight ETM4x driver
In-Reply-To: <1429742451-11465-2-git-send-email-mathieu.poirier@linaro.org>
References: <1429742451-11465-1-git-send-email-mathieu.poirier@linaro.org>
 <1429742451-11465-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <CACRpkdak5-iuWEDAvhDq3uwYobK+tW_N-t-QaY+-5TUSCa7uOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 12:40 AM, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:

> From: Pratik Patel <pratikp@codeaurora.org>
>
> This driver manages the CoreSight ETMv4 (Embedded Trace Macrocell) IP block
> to support HW assisted tracing on ARMv7 and ARMv8 architectures.
>
> Signed-off-by: Pratik Patel <pratikp@codeaurora.org>
> Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

(...)
> +/* The number of ETMv4 currently registered */
> +static int etm4_count;
> +static struct etmv4_drvdata *etmdrvdata[NR_CPUS];

Don't you need a mutex or something around etm4_count so
as to protect it? You could also make it an atomic.

Also why is it a signed int ... unsigned int?

I know, lame comments, the runtime PM stuff looks perfect now,
someone had a refcount comment but it's doing the right thing.

Yours,
Linus Walleij
