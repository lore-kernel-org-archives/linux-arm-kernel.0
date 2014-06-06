From: abrestic@chromium.org (Andrew Bresticker)
Date: Fri, 6 Jun 2014 15:46:41 -0700
Subject: [PATCH] ARM: EXYNOS: mcpm: Don't rely on firmware's
 secondary_cpu_start
In-Reply-To: <CAD=FV=U6cUNd4tZ1q3WUMkNpU-O-1yEbnEPuGkctwi_8UkBEkA@mail.gmail.com>
References: <1402090985-8061-1-git-send-email-dianders@chromium.org>
 <alpine.LFD.2.11.1406061831310.25775@knanqh.ubzr>
 <CAD=FV=U6cUNd4tZ1q3WUMkNpU-O-1yEbnEPuGkctwi_8UkBEkA@mail.gmail.com>
Message-ID: <CAL1qeaFYqqDvYYhKMPwaP8TcyCtvr8afWi7GZN1E3d7ov6LJYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> If this is all that is needed to solve the problem being discussed in
>> the other thread I have absolutely no issue with such a workaround going
>> into mainline.
>
> This plus the CCI fix that Andrew is planning to post.

Right - we'll need a patch to enable the CCI port for the cluster we
booted on at boot and resume time since the first CPU up won't enter
through exynos_pm_power_up_setup().  I'll try to post something later
today or Monday.
