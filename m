From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Fri, 28 Nov 2014 14:09:29 +0200
Subject: [PATCH] serial: 8250_dw: Handle no_console_suspend when uart
 loses state
In-Reply-To: <5469B828.90401@intel.com>
References: <1416011556-23422-1-git-send-email-dianders@chromium.org>
 <5469B828.90401@intel.com>
Message-ID: <20141128120929.GC28114@kuha.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 09:56:08AM +0100, Loic Poulain wrote:
> >In certain suspend modes on certain boards the 8250 UART may lose
> >state when the device goes to suspend.  If we're using
> >no_console_suspend this can cause lots of problems during resume.
> >
> >Let's cache the basic UART config registers at suspend time and if we
> >notice that the UART loses state (by looking at a canary stored in the
> >scratch register) we'll restore it.
> 
> If I'm not wrong, it's already done in acpi_lpss suspend/resume (for
> 8250_dw).
> Commit c78b0830667a7e7c1f0ca65b76b33166a84806b3.

FYI, we are not saving any UART specific registers in acpi_lpss.c nor
any other bus controller's registers that are part of the LPSS block.
We are saving/restoring only the context of lpss specific register
there.

Cheers,

-- 
heikki
