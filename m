From: viresh.kumar@st.com (viresh kumar)
Date: Wed, 11 May 2011 12:49:42 +0530
Subject: [QUERY] Behavior of spi slave memories w.r.t chip select signal.
In-Reply-To: <20110511071754.GN26703@pulham.picochip.com>
References: <4DCA0B77.8060700@st.com>
	<20110511071754.GN26703@pulham.picochip.com>
Message-ID: <4DCA388E.5060003@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2011 12:47 PM, Jamie Iles wrote:
> What SPI controller are you using?  I've seen a similar issue with the 
> Synopsys DesignWare SPI controller where the controller manages the chip 
> select itself, and once the FIFO is emptied the CS goes away, but the 
> flash chip requires it to stay high for the whole transaction.  In this 
> case the workaround is to use a GPIO as a chip select and there are 
> other controllers that do the same thing for the same reason (I think 
> that pxa2xx_spi is one of them).

I am using amba pl022 controller and using external gpio's to control
chip select signal. cs is kept low for entire message, but still i am facing
this issue.

-- 
viresh
