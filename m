From: dianders@chromium.org (Doug Anderson)
Date: Fri, 12 Sep 2014 08:12:04 -0700
Subject: [PATCH RESEND v9 1/5] rtc: max77686: Allow the max77686 rtc to
 wakeup the system
In-Reply-To: <1410509864-10019-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1410509864-10019-1-git-send-email-javier.martinez@collabora.co.uk>
 <1410509864-10019-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=Vu3u=KfUNUpL6qcr0Fp42WbY8AqfOXyWr-D3KW1PucxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 12, 2014 at 1:17 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> From: Doug Anderson <dianders@chromium.org>
>
> The max77686 includes an RTC that keeps power during suspend.  It's
> convenient to be able to use it as a wakeup source.
>
> NOTE: due to wakeup ordering problems this patch alone doesn't work so
> well on exynos5250-snow.  You also need something that brings the i2c
> bus up before the max77686 wakeup runs.

This note made sense when the patch was first submitted, but no longer
does since the i2c change landed.  See:

b19c195 i2c: s3c2410: resume the I2C controller earlier
