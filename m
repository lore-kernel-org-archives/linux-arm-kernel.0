From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Thu, 29 Mar 2018 18:00:30 -0500
Subject: RFC: Using regmap in ARM64 for EL3 register access
Message-ID: <0cf26fec-a702-9d57-c7e0-85064690133c@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm working on an ARM64 architecture that needs to manipulate some 
protected registers that are only accessible in EL3. Linux is running at 
EL1 which doesn't have the proper permissions for these registers.

Since U-Boot is running at the higher EL3, we communicate to the U-Boot 
functions through a SMC mechanism.

The regmap framework seems like a good match for accessing these 
registers. We need the same functionality as I2C and SPI regmaps - read, 
write, and update registers.

Any comments or suggestions about using regmap for this purpose? Is 
there a better method?

Thanks,

Thor
