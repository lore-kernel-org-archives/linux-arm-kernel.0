From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 11 Apr 2015 23:28:23 +0200
Subject: [PATCH 0/2] ARM: mvebu: Add DLINK-DNS327L support
In-Reply-To: <1428784160-19431-1-git-send-email-andrew@ncrmnt.org>
References: <1428784160-19431-1-git-send-email-andrew@ncrmnt.org>
Message-ID: <20150411212823.GI5244@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> When power button is pressed to turn the NAS off, weltrend signals 
> the SoC by driving mpp63 line low. Apparently right now pinctrl assumes
> that this line can only work as 'gpo' that screws up gpio-buttons driver.
> Since without gpio-buttons, mpp63 works as input properly via sysfs 
> interface, I've added a patch for pinctrl-armada-370.c that fixes the 
> issue.

Hi Andrew

This is odd. I just checked the Marvell datasheets, and they list this
pin a GPO.

We probably want Thomas or Gregory to check this with Marvell.

   Andrew
