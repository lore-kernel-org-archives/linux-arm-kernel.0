From: loic.poulain@intel.com (Loic Poulain)
Date: Mon, 17 Nov 2014 09:56:08 +0100
Subject: [PATCH] serial: 8250_dw: Handle no_console_suspend when uart
 loses state
In-Reply-To: <1416011556-23422-1-git-send-email-dianders@chromium.org>
References: <1416011556-23422-1-git-send-email-dianders@chromium.org>
Message-ID: <5469B828.90401@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> In certain suspend modes on certain boards the 8250 UART may lose
> state when the device goes to suspend.  If we're using
> no_console_suspend this can cause lots of problems during resume.
>
> Let's cache the basic UART config registers at suspend time and if we
> notice that the UART loses state (by looking at a canary stored in the
> scratch register) we'll restore it.

If I'm not wrong, it's already done in acpi_lpss suspend/resume (for 
8250_dw).
Commit c78b0830667a7e7c1f0ca65b76b33166a84806b3.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
