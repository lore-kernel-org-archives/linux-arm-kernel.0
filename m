From: aneesh@ti.com (Aneesh V)
Date: Fri, 16 Mar 2012 01:31:15 +0530
Subject: [PATCH v2 0/7] Add TI EMIF SDRAM controller driver
In-Reply-To: <20120315190444.GE11142@kroah.com>
References: <1331835457-5390-1-git-send-email-aneesh@ti.com>
 <20120315190444.GE11142@kroah.com>
Message-ID: <4F624A8B.7040407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 March 2012 12:34 AM, Greg KH wrote:
> On Thu, Mar 15, 2012 at 11:47:30PM +0530, Aneesh V wrote:
>> Add a driver for the EMIF SDRAM controller used in TI SoCs
>>
>> EMIF is an SDRAM controller that supports, based on its revision,
>> one or more of LPDDR2/DDR2/DDR3 protocols.This driver adds support
>> for LPDDR2.
>>
>> The driver supports the following features:
>> - Calculates the DDR AC timing parameters to be set in EMIF
>>    registers using data from the device data-sheets and based
>>    on the DDR frequency. If data from data-sheets is not available
>>    default timing values from the JEDEC spec are used. These
>>    will be safe, but not necessarily optimal
>> - API for changing timings during DVFS or at boot-up
>
> Is this a kernel/user API, or just an in-kernel API?

That's just an in-kernel API or more precisely callbacks to be
registered for DDR frequency change events.

thanks,
Aneesh
