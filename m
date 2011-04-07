From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 07 Apr 2011 12:35:01 +0200
Subject: [PATCH] ARM: Allow for kernel command line concatenation
In-Reply-To: <1302164236-1516-1-git-send-email-oskar.andero@sonyericsson.com>
References: <1302164236-1516-1-git-send-email-oskar.andero@sonyericsson.com>
Message-ID: <1302172525.24493.7.camel@t41.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-04-07 at 10:17 +0200, oskar.andero at sonyericsson.com wrote:
> +config CMDLINE_EXTEND
> +	bool "Extend bootloader kernel arguments"
> +	depends on CMDLINE != ""
> +	help
> +	  The default kernel command string will be concatenated with the
> +	  arguments provided by the boot loader.

This suggests the parameters provided by the boot loader will override
corresponding parameters of the default kernel command string. Is that
correct (for all possible parameters)?

Either way, shouldn't it be documented, perhaps in this help text, what
will happen if a parameter of the default kernel command string and a
parameter provided by the boot loader somehow conflict?


Paul Bolle
