From: mingo@kernel.org (Ingo Molnar)
Date: Thu, 2 May 2013 09:30:20 +0200
Subject: [PATCH -v7 10/11] arm, change reboot_mode to use enum reboot_mode
In-Reply-To: <1367428011-17123-11-git-send-email-holt@sgi.com>
References: <1367428011-17123-1-git-send-email-holt@sgi.com>
 <1367428011-17123-11-git-send-email-holt@sgi.com>
Message-ID: <20130502073020.GC26361@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Robin Holt <holt@sgi.com> wrote:

>  #ifndef __ASSEMBLY__
>  
>  #include <linux/types.h>
> +#include <linux/reboot.h>
>  
>  void iop3xx_map_io(void);
>  void iop_init_cp6_handler(void);
>  void iop_init_time(unsigned long tickrate);
> -void iop3xx_restart(char, const char *);
> +void iop3xx_restart(enum reboot_mode, const char *);

IMO the introduction of the enum is making things cleaner here all around.

As long as it's an equivalent transformation for ARM with no reduction in 
functionality (i.e. please fix any bugs Russell found), this all looks 
like a nice series.

Is there no parameter namespace clash between reboot modifier strings on 
various architectures? I.e. 's' meaning something on x86 and meaning a 
different thing on ARM or some other architecture.

Thanks,

	Ingo
