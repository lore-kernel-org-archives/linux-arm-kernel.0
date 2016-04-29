From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 28 Apr 2016 17:42:44 -0700
Subject: [PATCH v7 1/5] of/serial: move earlycon early_param handling to
 serial
In-Reply-To: <1459431629-27934-2-git-send-email-aleksey.makarov@linaro.org>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
 <1459431629-27934-2-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <20160429004244.GA31752@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 04:40:23PM +0300, Aleksey Makarov wrote:
> From: Leif Lindholm <leif.lindholm@linaro.org>
> 
> We have multiple "earlycon" early_param handlers - merge the DT one into
> the main earlycon one.  It's a cleanup that also will be useful
> to defer setting up DT console until ACPI/DT decision is made.
> 
> Rename the exported function to avoid clashing with the function from
> arch/microblaze/kernel/prom.c
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/fdt.c              | 11 +----------
>  drivers/tty/serial/earlycon.c |  2 +-
>  include/linux/of_fdt.h        |  2 ++
>  3 files changed, 4 insertions(+), 11 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
