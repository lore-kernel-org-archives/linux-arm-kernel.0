From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 May 2012 12:57:51 +0000
Subject: [PATCH 7.2/15] ARM: ux500: Disable SMSC911x platform code
 registration when DT is enabled
In-Reply-To: <4F967986.6090808@linaro.org>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdZzAQNJ9ejKJJQJhEPjO9VO+fPHmPeCErg8XOj-dLc3gA@mail.gmail.com>
 <4F967986.6090808@linaro.org>
Message-ID: <201205031257.52100.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 April 2012, Lee Jones wrote:
> From: Lee Jones <lee.jones@linaro.org>
> Date: Tue, 24 Apr 2012 10:54:25 +0100
> Subject: [PATCH 7.2/15] ARM: ux500: Disable SMSC911x platform code registration when DT is enabled
> 
> Now the SCMC911x is correctly enabled in Device Tree, there is no need
> to continue registering it from platform code. In fact, if we continue
> doing so, the system will throw an error on boot.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
> index 50809af..9dbd34b 100644
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -612,7 +612,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
>  static struct platform_device *snowball_of_platform_devs[] __initdata = {
>         &snowball_led_dev,
>         &snowball_key_dev,
> -       &snowball_sbnet_dev,
>         &ab8500_device,
>  };
>  

This version of the patch looks good, the version that was applied does not.
The same is true for "ARM: ux500: Fork cpu-db8500 platform_devs for
sequential DT enablement". I only noticed because I get new build warnings
for the bogus code now. It appears that some of the prerequisites for these
patches, in particular "ARM: ux500: New DT:ed snowball_platform_devs for
one-by-one device enablement" and "ARM: ux500: New DT:ed u8500_init_devices
for one-by-one device enablement" are missing now and the two patches on
top were mismerged.

Linus and Lee, what's going on here?

	Arnd
