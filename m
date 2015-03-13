From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 13 Mar 2015 20:36:11 +0100
Subject: [PATCH 01/12] ARM: Remove mach-msm and associated ARM
 architecture code
In-Reply-To: <1426270185-19510-2-git-send-email-sboyd@codeaurora.org>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
 <1426270185-19510-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <1426275371.7778.10.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've checked this series with my local Kconfig checker (for no other
reason than that it removes board-sapphire.c and I had promised to do so
too a week ago).

On Fri, 2015-03-13 at 11:09 -0700, Stephen Boyd wrote:
> --- a/arch/arm/mach-msm/Kconfig
> +++ /dev/null
> -config MSM_SMD
> -	bool

After this series MSM_SMD is still referenced in drivers/char/Kconfig
(sin the entry for MSM_SMD_PKT) and drivers/tty/serial/Kconfig (in the
entry for SERIAL_MSM_SMD).

So I think those two Kconfing entries, drivers/char/msm_smd_pkt.c,
drivers/tty/serial/msm_smd_tty.c, and the related lines in the two
Makefiles involved, can be removed too. (A quick glance at those tow
entries and those two files suggests there are no second order effects
from removing all that.)


Paul Bolle
