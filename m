From: greg@kroah.com (Greg KH)
Date: Thu, 15 Mar 2012 12:04:44 -0700
Subject: [PATCH v2 0/7] Add TI EMIF SDRAM controller driver
In-Reply-To: <1331835457-5390-1-git-send-email-aneesh@ti.com>
References: <1331835457-5390-1-git-send-email-aneesh@ti.com>
Message-ID: <20120315190444.GE11142@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 11:47:30PM +0530, Aneesh V wrote:
> Add a driver for the EMIF SDRAM controller used in TI SoCs
> 
> EMIF is an SDRAM controller that supports, based on its revision,
> one or more of LPDDR2/DDR2/DDR3 protocols.This driver adds support
> for LPDDR2.
> 
> The driver supports the following features:
> - Calculates the DDR AC timing parameters to be set in EMIF
>   registers using data from the device data-sheets and based
>   on the DDR frequency. If data from data-sheets is not available
>   default timing values from the JEDEC spec are used. These
>   will be safe, but not necessarily optimal
> - API for changing timings during DVFS or at boot-up

Is this a kernel/user API, or just an in-kernel API?

thanks,

greg k-h
