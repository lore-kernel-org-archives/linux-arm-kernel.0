From: peda@axentia.se (Peter Rosin)
Date: Tue, 19 Jun 2018 15:05:50 +0200
Subject: [PATCH 02/11] tpm/tpm_i2c_infineon: switch to i2c_lock_segment
In-Reply-To: <20180619125618.GB5609@linux.intel.com>
References: <20180615101506.8012-1-peda@axentia.se>
 <20180615101506.8012-3-peda@axentia.se>
 <20180619125618.GB5609@linux.intel.com>
Message-ID: <eb583028-dfcb-7f1b-c2a1-236ad4c5c2b5@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-06-19 14:56, Jarkko Sakkinen wrote:
> On Fri, Jun 15, 2018 at 12:14:57PM +0200, Peter Rosin wrote:
>> Locking the root adapter for __i2c_transfer will deadlock if the
>> device sits behind a mux-locked I2C mux. Switch to the finer-grained
>> i2c_lock_segment. If the device does not sit behind a mux-locked mux,
>> the two locking variants are equivalent.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> Can you quickly explain (or give a reference) the difference with these
> functions? Not an expert in this area. Thanks.

There are some words in the cover letter. If you need more, there's
always Documentation/i2c/i2c-topology. Hope that helps, otherwise I'll
try to explain better...

Cheers,
Peter
