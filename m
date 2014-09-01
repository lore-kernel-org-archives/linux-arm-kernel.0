From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Sep 2014 17:58:53 +0100
Subject: [Linaro-acpi] [RFC PATCH for Juno 1/2] net: smsc911x add support
 for probing from ACPI
In-Reply-To: <20140901165333.GE608@arm.com>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <1409583961-7466-2-git-send-email-hanjun.guo@linaro.org>
 <2861461.8zNpLC3I2n@wuerfel>
 <20140901152854.GJ2953@xora-haswell.xora.org.uk>
 <20140901165333.GE608@arm.com>
Message-ID: <20140901165853.GJ29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 05:53:33PM +0100, Catalin Marinas wrote:

> Confused. Then how come smsc911x_drv_probe() has this line:

> 	acpi_handle *ahandle = ACPI_HANDLE(&pdev->dev);

> without any #ifdef's.

There's a stub smsc911x_probe_config_acpi() provided in the non-ACPI
case, Arnd's suggestion is basically to remove the stub.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140901/ae5872b2/attachment.sig>
