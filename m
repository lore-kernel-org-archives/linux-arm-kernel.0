From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Tue, 29 Jan 2013 17:13:09 -0500
Subject: [PATCH] mailbox: prevent pl320-ipc code from breaking none-AMBA
 systems
In-Reply-To: <1807311.dyJeq56cRL@vostro.rjw.lan>
References: <1359477413-27881-1-git-send-email-mark.langsdorf@calxeda.com>,
 <1807311.dyJeq56cRL@vostro.rjw.lan>
Message-ID: <21672683C5A3814BB4DB938EBE482DE435D976610A@IAD2MBX09.mex02.mlsrvr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Rafael J. Wysocki [rjw at sisk.pl]
> On Tuesday, January 29, 2013 10:36:53 AM Mark Langsdorf wrote:
> > The pl320-ipc code depends on ARM AMBA, and should have the dependency
> > in its Kconfig.
> 
> May I fold this into "ARM / highbank: add support for pl320 IPC"?

Yes. I didn't want to regenerate the patch series =)

--Mark Langsdorf
Calxeda, Inc.

> Signed-off-by: Mark Langsdorf <mark.langsdorf@calxeda.com>
> ---
>  drivers/mailbox/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 9489554..9545c9f 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -8,6 +8,7 @@ menuconfig MAILBOX
>  if MAILBOX
>  config PL320_MBOX
>       bool "ARM PL320 Mailbox"
> +     depends on ARM_AMBA
>       help
>         An implementation of the ARM PL320 Interprocessor Communication
>         Mailbox (IPCM), tailored for the Calxeda Highbank. It is used to
>
--
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
