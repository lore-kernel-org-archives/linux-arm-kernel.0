From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 8 Nov 2017 11:17:59 +0530
Subject: [PATCH 2/3] dmaengine: qcom_hidma: add support for the new
 revision
In-Reply-To: <1733d997-6f3a-459a-b14f-b29823c3a8af@codeaurora.org>
References: <1509989180-22617-1-git-send-email-okaya@codeaurora.org>
 <1509989180-22617-2-git-send-email-okaya@codeaurora.org>
 <428c7106-8ebe-0c12-4576-1cfac422923e@arm.com>
 <0b24eb03-1f0e-ec65-b12b-65036ef7addc@codeaurora.org>
 <1733d997-6f3a-459a-b14f-b29823c3a8af@codeaurora.org>
Message-ID: <20171108054759.GN3187@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 06, 2017 at 05:09:29PM -0500, Sinan Kaya wrote:
> On 11/6/2017 1:15 PM, Sinan Kaya wrote:
> > On 11/6/2017 1:03 PM, Robin Murphy wrote:
> >>>  #ifdef CONFIG_ACPI
> >>>  		ret = strcmp(acpi_device_hid(adev), "QCOM8062");
> >>> +		if (ret)
> >>> +			ret = strcmp(acpi_device_hid(adev), "QCOM8063");
> >> This string-juggling looks to have already hit the point at which it
> >> doesn't scale well - it would be a lot nicer to make use of
> >> of_device_get_match_data() and the ACPI equivalent to abstract the
> >> version-specific data appropriately.
> > 
> > Sure, let me do some research.
> > 
> 
> I just wanted to double check here. 
> 
> This is what I can do:
> 1. Maintain different match tables for different driver capabilities.
> 2. Instead of doing open-coded strcmp, I can do match against different tables
> using acpi_match_device/of_match_device.
> 
> Hope this works for you.

Sounds better to me. You should have common match where capabilities are
same.

-- 
~Vinod
