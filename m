From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 4 Apr 2018 11:47:56 +0100
Subject: RFC: Using regmap in ARM64 for EL3 register access
In-Reply-To: <0cf26fec-a702-9d57-c7e0-85064690133c@linux.intel.com>
References: <0cf26fec-a702-9d57-c7e0-85064690133c@linux.intel.com>
Message-ID: <7034387b-8dd9-77fa-95f0-63c805849ced@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 30/03/18 00:00, Thor Thayer wrote:
> Hi,
>
> I'm working on an ARM64 architecture that needs to manipulate some
> protected registers that are only accessible in EL3. Linux is running at
> EL1 which doesn't have the proper permissions for these registers.
>
If the hardware/IP registers are designed not to provide access to EL1,
then providing one in software by some means is simply wrong approach to
solve whatever issue you are trying to address here.

> Since U-Boot is running at the higher EL3, we communicate to the U-Boot
> functions through a SMC mechanism.
>
Please follow SMCCC to add any SMC interface.

> The regmap framework seems like a good match for accessing these
> registers. We need the same functionality as I2C and SPI regmaps - read,
> write, and update registers.
>
No, providing register access to EL1 using regmap+SMC just defeats the
hardware security restrictions and may provide ways to exploit.
Why not abstract to the level of services you need ?

> Any comments or suggestions about using regmap for this purpose? Is
> there a better method?
>
If you are looking for power management features, then PSCI and SCMI are
couple of specifications to look at. I would really like to know more
details on your use case to provide any suggestions.


-- 
Regards,
Sudeep
