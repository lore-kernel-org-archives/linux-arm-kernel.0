From: rjui@broadcom.com (Ray Jui)
Date: Sun, 8 Feb 2015 09:56:18 -0800
Subject: [PATCH v9 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
In-Reply-To: <20150208162937.GB6033@katana>
References: <rjui@broadcom.com>
 <1423373126-30024-1-git-send-email-rjui@broadcom.com>
 <1423373126-30024-3-git-send-email-rjui@broadcom.com>
 <20150208162937.GB6033@katana>
Message-ID: <54D7A342.5030200@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/8/2015 8:29 AM, Wolfram Sang wrote:
> On Sat, Feb 07, 2015 at 09:25:25PM -0800, Ray Jui wrote:
>> Add initial support to the Broadcom iProc I2C controller found in the
>> iProc family of SoCs.
>>
>> The iProc I2C controller has separate internal TX and RX FIFOs, each has
>> a size of 64 bytes. The iProc I2C controller supports two bus speeds
>> including standard mode (100kHz) and fast mode (400kHz)
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Scott Branden <sbranden@broadcom.com>
>> Reviewed-by: Kevin Cernekee <cernekee@chromium.org>
> 
> Looks good. What kind of tests have you done with exactly this version of the
> driver (not earlier ones)?
> 
I did build test and ran i2cdetect on Cygnus BCM958300K combo board with
the 3.19 rc7 kernel, and then I back ported this driver to our 3.10
version of the production kernel (where we have complete audio driver
support), to run some audio playback tests, which involves using the
wolfson codec (through i2c). The only line I added when back porting to
the 3.10 kernel is of_i2c_register_devices at the end of probe.

Thanks,

Ray
