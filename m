From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jan 2014 16:10:02 +0100
Subject: [PATCH] ACPI: introduce CONFIG_ACPI_REDUCED_HARDWARE_ONLY to
 enforce this ACPI mode
In-Reply-To: <52D82671.6000200@linaro.org>
References: <1389731822-21336-1-git-send-email-al.stone@linaro.org>
 <201401161155.27592.arnd@arndb.de> <52D82671.6000200@linaro.org>
Message-ID: <201401171610.02887.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 January 2014, Al Stone wrote:
> Right; I assumed I had to have that SELECT.  My apologies -- I
> still cannot reproduce the warning.  I'll resubmit the patch
> incorporating the suggestion, though, since the result ends up
> being the same -- you must have ACPI and EXPERT selected in order
> to enable ACPI_REDUCED_HARDWARE_ONLY.
> 

You should never 'select' CONFIG_EXPERT from architecture code, that
is supposed to be a user-settable option. If you also select CONFIG_EXPERT
or have that enabled in the configuration, you will not get a warning.

	Arnd
