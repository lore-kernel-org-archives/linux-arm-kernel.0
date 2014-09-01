From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Sep 2014 18:14:51 +0100
Subject: [Linaro-acpi] [RFC PATCH for Juno 1/2] net: smsc911x add support
 for probing from ACPI
In-Reply-To: <5404A821.5020207@arm.com>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <1409583961-7466-2-git-send-email-hanjun.guo@linaro.org>
 <2861461.8zNpLC3I2n@wuerfel>
 <20140901152854.GJ2953@xora-haswell.xora.org.uk>
 <20140901165333.GE608@arm.com>
 <20140901165853.GJ29327@sirena.org.uk> <5404A821.5020207@arm.com>
Message-ID: <20140901171451.GH608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 06:08:49PM +0100, Sudeep Holla wrote:
> On 01/09/14 17:58, Mark Brown wrote:
> > On Mon, Sep 01, 2014 at 05:53:33PM +0100, Catalin Marinas wrote:
> >
> >> Confused. Then how come smsc911x_drv_probe() has this line:
> >
> >> 	acpi_handle *ahandle = ACPI_HANDLE(&pdev->dev);
> >
> >> without any #ifdef's.
> >
> > There's a stub smsc911x_probe_config_acpi() provided in the non-ACPI
> > case, Arnd's suggestion is basically to remove the stub.
> >
> 
> I think Catalin is referring to ACPI_HANDLE used without any #ifdefs
> 
> Catalin, few macros like ACPI_HANDLE and ACPI_PTR are defined in
> include/linux/acpi.h even when CONFIG_ACPI is not set mainly to
> avoid #ifdef's around simple assignments like the above one and one
> in platform_driver.acpi_match_table

My comment was to Graeme who said that #ifdef's were needed because
acpi_handle (lowercase) was not defined in the !CONFIG_ACPI case.
However, further down in the patch it was used without any #ifdef's.

-- 
Catalin
