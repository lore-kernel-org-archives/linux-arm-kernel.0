From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 13 Apr 2015 16:39:10 +0200
Subject: [PATCH 0/2] ARM: mvebu: Add DLINK-DNS327L support
In-Reply-To: <20150411212823.GI5244@lunn.ch>
References: <1428784160-19431-1-git-send-email-andrew@ncrmnt.org>
 <20150411212823.GI5244@lunn.ch>
Message-ID: <552BD50E.9080403@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 11/04/2015 23:28, Andrew Lunn wrote:
>> When power button is pressed to turn the NAS off, weltrend signals 
>> the SoC by driving mpp63 line low. Apparently right now pinctrl assumes
>> that this line can only work as 'gpo' that screws up gpio-buttons driver.
>> Since without gpio-buttons, mpp63 works as input properly via sysfs 
>> interface, I've added a patch for pinctrl-armada-370.c that fixes the 
>> issue.
> 
> Hi Andrew
> 
> This is odd. I just checked the Marvell datasheets, and they list this
> pin a GPO.
> 
> We probably want Thomas or Gregory to check this with Marvell.

I have check on the datasheet I have (in case of it was different of the public one)
and for all the variant of the Armada 370:  88F6710, 88F6707, and 88F6W11 the MPP63
is list as GPO.

I will ask Marvell to see if it was a typo on their datasheet.


Thanks,

Gregory


> 
>    Andrew
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
