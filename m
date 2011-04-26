From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 26 Apr 2011 17:07:47 +0200
Subject: [PM8921 MFD V5 0/6] pm8921 core and subdevices
In-Reply-To: <1302039657-19395-1-git-send-email-adharmap@codeaurora.org>
References: <1302039657-19395-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <20110426150746.GF3175@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhijeet,

On Tue, Apr 05, 2011 at 02:40:51PM -0700, Abhijeet Dharmapurikar wrote:
> This patch series adds support for pmic 8921 chip and its subdevices.
> The pmic 8921 chip is used as a power management ic for 8960 based boards. It
> communicates over the ssbi bus, ssbi bus can be found here
> 
> https://patchwork.kernel.org/patch/601771/
> 
> The patch set contains support for interrupt, gpio and mpp (multi purpose pin)
> subdevices.
> 
> Note that gpio and mpp subdevices need the interrupt subdevice to
> be operational, this is becuase the reading the the value of gpio/mpp lines
> happens by doing a transaction over registers managed by the interrupt subdev.
> The code invokes a call on interrupt subdevice, rather than writing to those
> registers directly, avoiding race conditions.
I have applied patch #1 and #2 to my for-next branch. For 3 and4, I'll wait
for Grant's ACK. As for #5, I'd like to get an ACK from the current MSM
maintainers.
Finally, patch #6 will be applied last.


> Updates from V4
> Few things have changed in kernel proper since I last sent this series
> -The interrupt macro names have changed (more structured)- had to update the irq
> patch to use the new macro names
> - mfd_cell does not have platfrom_data anymore - use mfd data instead.
I'm currently moving that away from the mfd_cell structure, in my for-next
branch. mfd_cell now has a platform_data pointer back, and you should use
mfd_get_cell() if you really need to reach the mfd_cell pointer (which you
apparently don't). 
Could you please generate patchs 3 and 4 against this branch ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
