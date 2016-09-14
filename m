From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 14 Sep 2016 15:34:18 +0200 (CEST)
Subject: [PATCH v5 2/9] drivers: irqchip: Add STM32 external interrupts
 support
In-Reply-To: <facd1c7c-d696-eae1-02e4-5a0c9285add0@st.com>
References: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
 <1473432124-6784-3-git-send-email-alexandre.torgue@st.com>
 <alpine.DEB.2.20.1609131713490.6233@nanos>
 <6941f61d-0b33-4108-0135-b11887cd0488@st.com>
 <alpine.DEB.2.20.1609141103420.6233@nanos>
 <facd1c7c-d696-eae1-02e4-5a0c9285add0@st.com>
Message-ID: <alpine.DEB.2.20.1609141532510.6233@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Sep 2016, Alexandre Torgue wrote:
> On 09/14/2016 11:19 AM, Thomas Gleixner wrote:
> > 
> > Now what really bugs me is that you do that at all. An interrupt which is
> > freed must be masked already. Why is it unmasked in the first place?
> 
> Honestly I don't know. When "devm_free_irq" is called to release virq, there
> is no issue and interrupt is well masked. But, when I tried to use
> "irq_dispose_mapping(virq)" I observed that .free is called (child and parent
> domain) but interrupt is not masked.

Well, you just used some function in some context which is not relevant to
the normal operation. So adding that mask() is just paranoia for no value.

Thanks,

	tglx
