From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 17 Nov 2014 10:20:28 +0100
Subject: [PATCH] serial: 8250_dw: Handle no_console_suspend when uart
 loses state
In-Reply-To: <5469B828.90401@intel.com>
References: <1416011556-23422-1-git-send-email-dianders@chromium.org>
 <5469B828.90401@intel.com>
Message-ID: <4280750.Abh5aXOcW7@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 17. November 2014, 09:56:08 schrieb Loic Poulain:
> > In certain suspend modes on certain boards the 8250 UART may lose
> > state when the device goes to suspend.  If we're using
> > no_console_suspend this can cause lots of problems during resume.
> > 
> > Let's cache the basic UART config registers at suspend time and if we
> > notice that the UART loses state (by looking at a canary stored in the
> > scratch register) we'll restore it.
> 
> If I'm not wrong, it's already done in acpi_lpss suspend/resume (for
> 8250_dw).
> Commit c78b0830667a7e7c1f0ca65b76b33166a84806b3.

It looks like it, but of course only takes into account devices probed via 
acpi, missing the devices probed via devicetree.

So it looks like we need Doug's solution somehow, question would be if it 
should be excluded on acpi platforms.


Heiko
