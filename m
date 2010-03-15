From: bgat@billgatliff.com (Bill Gatliff)
Date: Mon, 15 Mar 2010 08:04:25 -0500
Subject: QUERY: How to handle sharing of interrupt between different
	peripherals.
In-Reply-To: <4B9DD9F0.60603@st.com>
References: <4B9DB99A.5040104@st.com>		<1b68c6791003142218q24fd8516id75d6964201da3f2@mail.gmail.com>		<4B9DD766.7010504@st.com>	<1b68c6791003142350t1a671bf0k4777d8d4df8c5ab7@mail.gmail.com>
	<4B9DD9F0.60603@st.com>
Message-ID: <4B9E3059.6030608@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh KUMAR wrote:
> Second: Now UART, SDIO, SPI, I2S all have a common interrupt line, this is what
> we need to handle. For this IRQF_SHARED is a better way.
>   

No, chained handlers are the better way.

For example, your UARTs might be 16550-compatible. But you won't be able
to use the already well-tested 16550 driver if it doesn't already use
IRQF_SHARED.  I haven't looked to see if it does, but that would be just
one example...


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat at billgatliff.com
