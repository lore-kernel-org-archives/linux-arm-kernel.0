From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sun, 14 Sep 2014 18:38:58 +0200
Subject: [v4, 1/9] ACPI / PM: Let acpi_dev_pm_detach() return an error code
In-Reply-To: <20140912210553.GA27924@core.coreip.homeip.net>
References: <1410262570-22785-2-git-send-email-ulf.hansson@linaro.org>
 <20140912210553.GA27924@core.coreip.homeip.net>
Message-ID: <6318611.DnX9cEgMjk@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 12, 2014 02:05:53 PM Dmitry Torokhov wrote:
> Hi Ulf,
> 
> On Tue, Sep 09, 2014 at 01:36:02PM +0200, Ulf Hansson wrote:
> > To give callers the option of acting on a errors while removing the
> > pm_domain ops for the device in the ACPI PM domain, let
> > acpi_dev_pm_detach() return an int to provide the error code.
> 
> So how would callers handle the errors? As far as I can see
> acpi_dev_pm_detach() is called from ->remove() and ->shutdown() methods, where
> there is no meaningful strategy to handle errors as you are past the point of
> no return and you keep on tearing down the device.

This is specifically for what patch [3/9] is doing AFAICS.  

The existing callers don't need to worry about this.

Rafael
