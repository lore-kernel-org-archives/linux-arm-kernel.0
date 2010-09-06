From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 6 Sep 2010 11:50:07 +0800
Subject: [PATCH] ARM: pxa27x_keypad: added a comment to explain
	clear_wakeup_event callback
In-Reply-To: <1283700790-3558-1-git-send-email-mark.brown314@gmail.com>
References: <1283700790-3558-1-git-send-email-mark.brown314@gmail.com>
Message-ID: <AANLkTi=9tbLYZO7QPCBiEeUTeedz+wuaAWanEuY4CSO2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 5, 2010 at 11:33 PM, Mark F. Brown <mark.brown314@gmail.com> wrote:
> Signed-off-by: Mark F. Brown <mark.brown314@gmail.com>
> ---
> ?arch/arm/plat-pxa/include/plat/pxa27x_keypad.h | ? ?9 +++++++++
> ?1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> index 73dacda..abcc36e 100644
> --- a/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> +++ b/arch/arm/plat-pxa/include/plat/pxa27x_keypad.h
> @@ -25,6 +25,13 @@
> ?*
> ?* 4. matrix key and direct key will use the same debounce_interval by
> ?* ? ?default, which should be sufficient in most cases
> + *
> + * pxa168 keypad platform specific parameter
> + *
> + * NOTE:
> + * clear_wakeup_event callback is a workaround required to clear the
> + * keypad interrupt. The keypad wake must be cleared in addition to
> + * reading the MI/DI bits in the KPC register.
> ?*/
> ?struct pxa27x_keypad_platform_data {
>
> @@ -52,6 +59,8 @@ struct pxa27x_keypad_platform_data {
>
> ? ? ? ?/* key debounce interval */
> ? ? ? ?unsigned int ? ?debounce_interval;
> +
> + ? ? ? /* clear wakeup event requirement for pxa168 */
> ? ? ? ?void ? ? ? ? ? ?(*clear_wakeup_event)(void);
> ?};
>
> --
> 1.7.0.4
>
>

Merged into below commit, and 'devel' branch pushed.

  ARM: pxa27x_keypad: added wakeup event handler for keypad interrupts

Thanks.
