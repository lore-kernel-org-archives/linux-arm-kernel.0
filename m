From: alex.aring@gmail.com (Alexander Aring)
Date: Fri, 13 Nov 2015 13:22:37 +0100
Subject: [RFCv2 2/2] rpi: add support to enable usb power domain
In-Reply-To: <563B0217.4030307@lategoodbye.de>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
 <1446590711-18928-3-git-send-email-alex.aring@gmail.com>
 <563B0217.4030307@lategoodbye.de>
Message-ID: <20151113122231.GA2959@omega>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 08:15:35AM +0100, Stefan Wahren wrote:
...
> >+	bool "Raspberry Pi power domain driver"
> >+	depends on ARCH_BCM2835
> >+	depends on RASPBERRYPI_FIRMWARE
> >+	select PM_GENERIC_DOMAINS if PM
> 
> Since PM_GENERIC_DOMAINS_OF depends on PM_GENERIC_DOMAINS this line should
> be redundant.
> 

I can't remove the line:

select PM_GENERIC_DOMAINS if PM

here. It's true that "PM_GENERIC_DOMAINS_OF depends on PM_GENERIC_DOMAINS",
but Kconfig can't handle the dependency here with select. That's why
sometimes people teaches me "select is evil".

I will get:

warning: (RASPBERRYPI_POWER) selects PM_GENERIC_DOMAINS_OF which has
unmet direct dependencies (PM_GENERIC_DOMAINS && OF)

otherwise.

Nevertheless we can't also use "depends on PM_GENERIC_DOMAINS if PM"
because, PM_GENERIC_DOMAINS is a hidden entry (has no Kconfig prompt).

- Alex
