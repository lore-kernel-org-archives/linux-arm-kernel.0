From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 08 Jan 2013 10:44:55 +0200
Subject: [PATCH 0/3] ALSA: pxa27x: ac97 reset fixes
In-Reply-To: <1357595714-13698-1-git-send-email-mikedunn@newsguy.com>
References: <1357595714-13698-1-git-send-email-mikedunn@newsguy.com>
Message-ID: <50EBDC87.1030207@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/13 23:55, Mike Dunn wrote:
> AC97 reset is broken on the pxa27x.  These patches fix it by addressing multiple
> problems:
>   - cold reset fails because the GCR register is not set correctly
>   - warm reset fails because some code used to work around a hardware bug is
>     broken
>   - the intent of the work-around code is obfuscated by unfortunate function
>     naming
> 
> This patch set replaces some earlier individual patches that had some problems.
> Thanks Robert and Igor.
> 
> Changelog:
> v2:
>   - don't specify the LPM flag DRIVE_HIGH in #define for the mfp config
>   - patches 2 and 3 are combined into one patch
>   - mfp level and direction are set only once, during driver initialization
> 
> Mike Dunn (3):
>   ALSA: pxa2xx: fix ac97 cold reset
>   ALSA: pxa27x: fix ac97 warm reset
>   ALSA: pxa27x: rename pxa27x_assert_ac97reset()

I believe all three patches should go through Mark's tree.
Mark, at least patches 1 and 2 are also stable material,
can you please, add stable tags?

Thanks.

> 
>  arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |    3 ++
>  arch/arm/mach-pxa/pxa27x.c                  |   24 ++++++++++++------
>  sound/arm/pxa2xx-ac97-lib.c                 |   34 +++++++++++++++++++++-----
>  3 files changed, 46 insertions(+), 15 deletions(-)
> 

-- 
Regards,
Igor.
