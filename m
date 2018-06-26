From: Alexander.Steffen@infineon.com (Alexander Steffen)
Date: Tue, 26 Jun 2018 12:07:21 +0200
Subject: [PATCH v2 01/10] tpm/tpm_i2c_infineon: switch to
 i2c_lock_bus(..., I2C_LOCK_SEGMENT)
In-Reply-To: <20180625102454.GA3845@linux.intel.com>
References: <20180620051803.12206-1-peda@axentia.se>
 <20180620051803.12206-2-peda@axentia.se>
 <20180625102454.GA3845@linux.intel.com>
Message-ID: <7703d6a2-b22c-104c-7390-b5143a504725@infineon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.06.2018 12:24, Jarkko Sakkinen wrote:
> On Wed, Jun 20, 2018 at 07:17:54AM +0200, Peter Rosin wrote:
>> Locking the root adapter for __i2c_transfer will deadlock if the
>> device sits behind a mux-locked I2C mux. Switch to the finer-grained
>> i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
>> sit behind a mux-locked mux, the two locking variants are equivalent.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Studied enough so that I can give
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Do not have hardware to test this, however.

I don't have a mux-locked I2C mux either, but at least I can confirm 
that this change did not break my existing test setup (SLB9635/SLB9645 
on Raspberry Pi 2B).

Tested-by: Alexander Steffen <Alexander.Steffen@infineon.com>

Alexander
