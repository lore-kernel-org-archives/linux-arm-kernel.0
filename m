From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 04 Nov 2015 08:52:51 +0000
Subject: [PATCH v7] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <8520D5D51A55D047800579B09414719801693C5C@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1446564227-4704-1-git-send-email-bharatku@xilinx.com>	<5638DE62.6050605@arm.com>	<8520D5D51A55D047800579B09414719801693C20@XAP-PVEXMBX01.xlnx.xilinx.com>
 <CABHD4K_BWU7-c1NM0y5ZwFkfpG0+c9_9DpwyNXNcTvavmy8rJw@mail.gmail.com>
 <8520D5D51A55D047800579B09414719801693C5C@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <5639C763.7000707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/15 07:54, Bharat Kumar Gogada wrote:
>>> Without #ifdefs if we compile driver for legacy, MSI structures will not be
>> available and we get compile time error.
>>
>> Sorry for nitpicking but at least can we use elegant version of #ifdefs .i.e. #if
>> IS_ENABLED() here ?
>>
> Since IS_ENABLED() is checked at runtime, compile time error would come for legacy.

You're seriously misguided. IS_ENABLED() is specifically designed *not*
to be checked at runtime, but instead to use the compiler optimization
phase to get rid of code sections at compile time.

	M.
-- 
Jazz is not dead. It just smells funny...
