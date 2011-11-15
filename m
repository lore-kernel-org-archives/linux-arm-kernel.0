From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Nov 2011 11:23:50 +0100
Subject: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
In-Reply-To: <4EC188D2.5080706@kernel.org>
References: <1321291857-26277-1-git-send-email-maxime.ripard@free-electrons.com>
 <1321291857-26277-3-git-send-email-maxime.ripard@free-electrons.com>
 <4EC188D2.5080706@kernel.org>
Message-ID: <4EC23DB6.1040503@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/11/2011 22:32, Jonathan Cameron wrote:
> Just one more query on the IIO_CHAN_INFO_SCALE read.
> Sorry, missed this last time.  Its late so I may be going
> mad but the units seem out by 1000.

Wow, you're right. Indeed, if you multiply the value returned by
read_raw and scale, you get a value in millivolts, not micro...

> Also mysterious short as return value type in read_raw.

I will resend a new patchset with these two fixes.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
