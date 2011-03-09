From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 8 Mar 2011 19:02:44 -0700 (MST)
Subject: [PATCH 5/7] Serial: OMAP: add runtime pm support for omap-serial
	driver
In-Reply-To: <87hbbdjc7y.fsf@ti.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
	<1298903958-6496-6-git-send-email-govindraj.raja@ti.com>
	<87r5am499h.fsf@ti.com>
	<AANLkTim35McK1cFFEXyS49D6b8CT+4pQfmKAswOn3e7_@mail.gmail.com>
	<87hbbdjc7y.fsf@ti.com>
Message-ID: <alpine.DEB.2.00.1103081849360.15132@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Govindraj,

what also would be good to find out is why the UART is apparently sending 
asynchronous wakeups even when the driver doesn't set 
SCR_REG.RX_CTS_WU_EN.  This seems contrary to the expectation that 34xx 
TRM vZH section 17.4.4.1.4.1 "Wake-up Interrupt" sets.  Could you please 
clarify under which circumstances the RX_CTS_WU_EN bit is used?  I suppose 
that, given that it's also mentioned under section 17.4.5.1.1 "Module 
Power Savings", it might only be used when SLEEP_MODE is enabled.


- Paul
