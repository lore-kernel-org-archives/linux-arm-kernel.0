From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Fri, 12 Sep 2014 14:05:53 -0700
Subject: [v4, 1/9] ACPI / PM: Let acpi_dev_pm_detach() return an error code
In-Reply-To: <1410262570-22785-2-git-send-email-ulf.hansson@linaro.org>
References: <1410262570-22785-2-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140912210553.GA27924@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Tue, Sep 09, 2014 at 01:36:02PM +0200, Ulf Hansson wrote:
> To give callers the option of acting on a errors while removing the
> pm_domain ops for the device in the ACPI PM domain, let
> acpi_dev_pm_detach() return an int to provide the error code.

So how would callers handle the errors? As far as I can see
acpi_dev_pm_detach() is called from ->remove() and ->shutdown() methods, where
there is no meaningful strategy to handle errors as you are past the point of
no return and you keep on tearing down the device.

Thanks. 

-- 
Dmitry
