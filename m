From: dianders@chromium.org (Doug Anderson)
Date: Mon, 8 Apr 2013 12:21:32 -0700
Subject: [PATCH] ARM: dts: fix bad merge of display timing node to
 exynos5250-smdk5250.dts
In-Reply-To: <51630C7C.9040003@gmail.com>
References: <1365439879-3398-1-git-send-email-dianders@chromium.org>
 <51630B26.1000102@samsung.com>
 <CAD=FV=Ui2C49Z=39qboo9CdETrea2z+_+Wc77pjfDWX26XtxJg@mail.gmail.com>
 <51630C7C.9040003@gmail.com>
Message-ID: <CAD=FV=UcKTBjKtyQFY4odTpBDKbNQEAHjyahqgNCsD570zq=pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

On Mon, Apr 8, 2013 at 11:29 AM, Kukjin Kim <kgene.kim@gmail.com> wrote:
> BTW, if any problems on current for-next, please kindly let me know.

I usually try to check linux-next at least once a week, but sometimes
it's more or less often.  At the moment I'm trying to track something
weird down but it seems like it has some userspace component to it.
I'll post a separate thread if I find a kernel problem there.

Aside from the RTC, my biggest problem right now is that reboot
stopped working at the same time as the common clock.  The
exynos5_restart() function is essentially behaving as a no-op since
the clock to the IP block that handles reset has been gated.  :(  The
bit "CLK_PMU_APBIF" is gated in "CLK_GATE_IP_PERIS". This used to be
ungated in exynos5_clk_ip_peris_ctrl().

I'm happy to test a patch that fixes this but I haven't yet had time
to try to fix it cleanly myself.


-Doug
