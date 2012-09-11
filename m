From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 11 Sep 2012 18:17:23 +0200
Subject: arm: mvebu: improve Kconfig options handling for pinctrl
In-Reply-To: <1347377834-19402-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347377834-19402-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <504F6413.9000401@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 05:37 PM, Thomas Petazzoni wrote:
> Sebastian, Andrew, Jason, Gr?gory,
> 
> As was mentionned during the review of the pinctrl driver, it would be
> better to have the Armada 370 and XP pinctrl drivers being select-ed
> by their respective Kconfig options. This was unfortunately not
> possible due to the fact that both of those SoCs were handled by the
> same Kconfig option.
> 
> This small patch set splits the Armada 370 and XP Kconfig option into
> three options (one hidden common option, two visible options), and
> then uses those two options to select the appropriate pinctrl driver.
> 
> Sebastian, would you mind carrying them in your pinctrl patch set? Or
> has your patch set already been merged by Jason, in which case Jason
> could handle those two patches as well? Please let me know what
> solution you chose and if I need to rebase this on a specific
> branch. For now, it's based on top of the v3 of the pinctrl-mvebu
> driver.
> 

I have tested the series for both board. It's OK for me you can
add my Acked-by.

Shouldn't we update the defconfig in the same time?

With the current defconfig MACH_ARMADA_370_XP is selected but not
visible and MACH_ARMADA_370 or MACH_ARMADA_XP are visible but not
selected.


> Thanks,
> 
> Thomas
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
