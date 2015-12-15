From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Tue, 15 Dec 2015 17:29:50 -0500
Subject: [PATCH 0/5] drivers/tty: make more bool drivers explicitly
 non-modular
In-Reply-To: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20151215222950.GH2772@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[[PATCH 0/5] drivers/tty: make more bool drivers explicitly non-modular] On 18/10/2015 (Sun 18:21) Paul Gortmaker wrote:

> This next set of patches to drivers/tty fixes up more drivers that would
> perhaps appear modular when looking at the code, but are controlled by
> a bool Kconfig.  We make sure they don't look modular and get rid
> of module related code in the drivers that would never be used.

[...]

> Paul Gortmaker (5):
>   drivers/tty: make hvc/hvc_vio.c explicitly non-modular
>   drivers/tty: make ehv_bytechan.c explicitly non-modular
>   drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular
>   drivers/tty/serial: make msm_serial.c explicitly non-modular
>   drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular

Hi Greg,

You've merged the #3 atmel patch and #5 the 8250_mtk patch; the msm_serial
patch (#4) is no longer applicable since the authors changed it to tristate.

That leaves the top two patches; both for PPC hardware.  Did you skip
those because you wanted them pushed through the powerpc tree?

If so, that is fine, I can do that.  Just let me know.

Thanks,
Paul.
--

> 
>  drivers/tty/ehv_bytechan.c         | 40 +++------------------------------
>  drivers/tty/hvc/hvc_vio.c          | 29 ++++--------------------
>  drivers/tty/serial/8250/8250_mtk.c | 35 ++++++-----------------------
>  drivers/tty/serial/atmel_serial.c  | 45 ++++----------------------------------
>  drivers/tty/serial/msm_serial.c    | 30 ++++---------------------
>  5 files changed, 22 insertions(+), 157 deletions(-)
> 
> -- 
> 2.6.1
> 
