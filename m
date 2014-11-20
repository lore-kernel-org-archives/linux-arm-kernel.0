From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 20 Nov 2014 07:10:35 -0800
Subject: [PATCH] tty: serial: msm_serial: Don't require DT aliases
In-Reply-To: <1415990361-8897-1-git-send-email-sboyd@codeaurora.org>
References: <1415990361-8897-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAMAWPa8m5Ey6ee8tK8n8g7T6XL7=ZfLzrQgbW9-2iPVWnUfigw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg,

On Fri, Nov 14, 2014 at 10:39 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> If there isn't a DT alias then of_alias_get_id() will return
> -ENODEV. This will cause the msm_serial driver to fail probe,
> when we want to keep the previous behavior where we generated a
> dynamic line number at probe time. Restore this behavior by
> generating a dynamic id if the line number is still negative
> after checking for an alias or in the non-DT case looking at the
> .id field of the platform device.
>
> Reported-by: Kevin Hilman <khilman@kernel.org>
> Tested-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Can you add this to tty-next.  Without this, all the ARM/qcom boards
do not boot in linux-next.

Thanks,

Kevin
