From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 30 Jun 2017 07:55:57 +0200
Subject: [RESEND PATCH] drm/hisilicon: Ensure LDI regs are properly
 configured.
In-Reply-To: <1498769678-12155-1-git-send-email-peter.griffin@linaro.org>
References: <1498769678-12155-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20170630055557.GA23014@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 09:54:38PM +0100, Peter Griffin wrote:
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
> ---
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
