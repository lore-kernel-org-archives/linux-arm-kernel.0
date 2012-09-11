From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 17:37:12 +0200
Subject: arm: mvebu: improve Kconfig options handling for pinctrl
In-Reply-To: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1347377834-19402-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian, Andrew, Jason, Gr?gory,

As was mentionned during the review of the pinctrl driver, it would be
better to have the Armada 370 and XP pinctrl drivers being select-ed
by their respective Kconfig options. This was unfortunately not
possible due to the fact that both of those SoCs were handled by the
same Kconfig option.

This small patch set splits the Armada 370 and XP Kconfig option into
three options (one hidden common option, two visible options), and
then uses those two options to select the appropriate pinctrl driver.

Sebastian, would you mind carrying them in your pinctrl patch set? Or
has your patch set already been merged by Jason, in which case Jason
could handle those two patches as well? Please let me know what
solution you chose and if I need to rebase this on a specific
branch. For now, it's based on top of the v3 of the pinctrl-mvebu
driver.

Thanks,

Thomas
