From: amworsley@gmail.com (Andrew Worsley)
Date: Mon, 16 Apr 2018 11:22:47 +1000
Subject: No subject
Message-ID: <20180416012248.25891-1-amworsley@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  This patch clears the remaining i2c buffer overrun problems that I see in my
hardware.  When run at 200kHz over 2 days and 17 hours there were *NO* faults seen
despite continously accessing the all the i2c devices. I feel the remaining issues
are related to the TPM not behaving properly at clock speeds of 285kHz or higher.
The other i2c hardware is fine up to maximum 400khz.  At these higher clock speeds
the TPM appears to fall behind and I see SDA held low after the TPM read and the
driver report bus arbitration lost errors.  Eventually the TPM completely stops
responding and SDA is held low. But accessing the other i2c hardware causes more
i2c clock pulses which lets the SDA go high again then the other i2c devices work
with out problems which further confirms our thinking that the TPM is source of the
remaining i2c problems.

  With the additional i2c fixes in the attached patch the Xilinx i2c driver
is working with out problems on our hardware. I recommend you consider adding these
changes which apply on top of the previous fixes that I sent.

  Thanks

        Andrew Worsley
