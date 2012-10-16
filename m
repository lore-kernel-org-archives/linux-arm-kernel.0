From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 16 Oct 2012 00:13:38 -0700
Subject: [RESEND PATCH v3 2/2] i2c: change id to let i2c-at91 work
In-Reply-To: <1350364668-21280-2-git-send-email-voice.shen@atmel.com>
References: <1350364668-21280-1-git-send-email-voice.shen@atmel.com>
 <1350364668-21280-2-git-send-email-voice.shen@atmel.com>
Message-ID: <20121016071338.GE5172@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 01:17:48PM +0800, Bo Shen wrote:
> From: voice <voice.shen@atmel.com>
> 
> The i2c core driver will turn the platform device ID to busnum
> When using platfrom device ID as -1, it means dynamically assigned
> the busnum. When writing code, we need to make sure the busnum,
> and call i2c_register_board_info(int busnum, ...) to register device
> if using -1, we do not know the value of busnum
> 
> In order to solve this issue, set the platform device ID as a fix number
> Here using 0 to match the busnum used in i2c_regsiter_board_info()
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
> Resend
>   Cc linux kernel stable mailing list
> ---
>  arch/arm/mach-at91/at91rm9200.c          |    2 +-
>  arch/arm/mach-at91/at91rm9200_devices.c  |    2 +-
>  arch/arm/mach-at91/at91sam9260.c         |    4 ++--
>  arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
>  arch/arm/mach-at91/at91sam9261.c         |    4 ++--
>  arch/arm/mach-at91/at91sam9261_devices.c |    2 +-
>  arch/arm/mach-at91/at91sam9263.c         |    2 +-
>  arch/arm/mach-at91/at91sam9263_devices.c |    2 +-
>  arch/arm/mach-at91/at91sam9rl_devices.c  |    2 +-
>  9 files changed, 11 insertions(+), 11 deletions(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
