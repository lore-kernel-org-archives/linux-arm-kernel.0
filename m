From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 19 Jun 2018 15:56:18 +0300
Subject: [PATCH 02/11] tpm/tpm_i2c_infineon: switch to i2c_lock_segment
In-Reply-To: <20180615101506.8012-3-peda@axentia.se>
References: <20180615101506.8012-1-peda@axentia.se>
 <20180615101506.8012-3-peda@axentia.se>
Message-ID: <20180619125618.GB5609@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2018 at 12:14:57PM +0200, Peter Rosin wrote:
> Locking the root adapter for __i2c_transfer will deadlock if the
> device sits behind a mux-locked I2C mux. Switch to the finer-grained
> i2c_lock_segment. If the device does not sit behind a mux-locked mux,
> the two locking variants are equivalent.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Can you quickly explain (or give a reference) the difference with these
functions? Not an expert in this area. Thanks.

/Jarkko
