From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Mon, 26 Oct 2015 18:58:18 -0300
Subject: [PATCH 01/10] pwm: lpc18xx_pwm: use pwm_set_chip_data
In-Reply-To: <1445895161-2317-2-git-send-email-o.schinagl@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-2-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <CAAEAJfD=Lvqx-4_SHJyhg9Q1T_CKhLaGYs+X_ttoVf_zh_Yvkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ Ariel)

Hi Oliver,

Not sure why there's some many people in Cc for such a silly change.
I guess you are using get_maintainers.pl on the entire patchset and get
this rather long list.

IMO, the value of submitting patches as part of a larger series is to be able to
push patches that need to be applied in some given order, or otherwise
have some kind of logical relationship between them.

However, this is not the case: it's just a very small change and has
no relation to the rest of the patches in the series.
I think a simple standalone patch would be better here.

Also, get_maintainer.pl is just a hint, and not meant to be used as-is.
In particular, you are missing the driver's author.

On 26 October 2015 at 18:32, Olliver Schinagl <o.schinagl@ultimaker.com> wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>
> The lpc18xx driver currently manipulates the pwm_device struct directly
> rather then using the pwm_set_chip_data. While the current method may
> save a clock cycle or two, it is more obvious that data is set to the
> chip pointer (especially since it is only a single int holding struct.
>
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> ---
>  drivers/pwm/pwm-lpc18xx-sct.c | 11 +++++++----
>  drivers/pwm/pwm-sun4i.c       | 11 +++++++++++
>  2 files changed, 18 insertions(+), 4 deletions(-)
>

...and this diffstat is obviously fishy.
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
