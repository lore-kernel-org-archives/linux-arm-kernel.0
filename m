From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 15 Mar 2010 10:07:46 +0530
Subject: QUERY: How to handle sharing of interrupt between different
	peripherals.
Message-ID: <4B9DB99A.5040104@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everybody,

In our SOC (SPEArxxx), we have few peripherals which share common interrupt
line. For example we can have GPIO (PL061), SPI (PL022) and SDIO (Arasan) sharing
same physical IRQ line. Now there is a register in SOC which can give status of
this interrupt line (i.e. source of interrupt). We have standard drivers for
all of these, and these drivers don't request IRQ in shared mode.

How should we handle these IRQs now. One way i have been thinking of is to write
a wrapper layer for this type of IRQs for our SOC, which will register actual
IRQ numbers. Standard drivers can be provided virtual IRQ numbers for
registration. Now this wrapper, based on source of interrupt can call the
irq_handler for standard drivers.

Is this approach correct? Or is there any standard way to resolve these issues.

regards,
viresh kumar.
