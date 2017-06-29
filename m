From: john.stultz@linaro.org (John Stultz)
Date: Thu, 29 Jun 2017 14:10:16 -0700
Subject: [RESEND PATCH] drm/hisilicon: Ensure LDI regs are properly
 configured.
In-Reply-To: <1498769678-12155-1-git-send-email-peter.griffin@linaro.org>
References: <1498769678-12155-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <CALAqxLX4FAA+USVqV2rnTWr3oQg57rWJK6z2OsyDuXdfEN9ihw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 1:54 PM, Peter Griffin <peter.griffin@linaro.org> wrote:
> This patch fixes the following soft lockup:
>   BUG: soft lockup - CPU#0 stuck for 23s! [weston:307]
>
> On weston idle-timeout the IP is powered down and reset
> asserted. On weston resume we get a massive vblank
> IRQ storm due to the LDI registers having lost some state.
>
> This state loss is caused by ade_crtc_atomic_begin() not
> calling ade_ldi_set_mode(). With this patch applied
> resuming from Weston idle-timeout works well.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

While the issue hasn't seemingly come up with Android, I've been
running with this patch in my tree for a while without issue. So..
Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
