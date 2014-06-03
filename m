From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 3 Jun 2014 13:33:18 -0700
Subject: [PATCH] tty: serial: msm: Fix section mismatch warning
In-Reply-To: <1401826402-1079-1-git-send-email-galak@codeaurora.org>
References: <1401826402-1079-1-git-send-email-galak@codeaurora.org>
Message-ID: <20140603203318.GB6582@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 03:13:22PM -0500, Kumar Gala wrote:
> WARNING: drivers/tty/built-in.o(.data+0x3544): Section mismatch in
> reference from the variable msm_platform_driver to the function
> .init.text:msm_serial_probe()
> The variable msm_platform_driver references
> the function __init msm_serial_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Where is this mismatch showing up at?  3.15-rc8, 3.16-rc1?  Somewhere
older or else?

thanks,

greg k-h
