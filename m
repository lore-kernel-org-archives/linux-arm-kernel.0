From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 May 2013 16:51:13 +0200
Subject: [RFC 2/8] ARM:global_timer: Add ARM global timer support.
In-Reply-To: <518BADBF.4070303@st.com>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081638.23100.arnd@arndb.de> <518BADBF.4070303@st.com>
Message-ID: <201305091651.13896.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 May 2013, Srinivas KANDAGATLA wrote:
> >> diff --git a/arch/arm/include/asm/global_timer.h b/arch/arm/include/asm/global_timer.h
> >> new file mode 100644
> >> index 0000000..46f9188
> >> --- /dev/null
> >> +++ b/arch/arm/include/asm/global_timer.h
> >> @@ -0,0 +1,12 @@
> >> +int __init global_timer_init(void __iomem *base, unsigned int timer_irq);
> > 
> > I don't see a need to call this from platform code for non-DT platforms, it
> > can easily be used with CLOCKSOURCE_OF_DECLARE() all the time I think.
> 
> sorry Am confused here.
> How would this work for non-DT?

It won't.

> Looking at the code in clocksource_of_init it just goes through the
> of_device_id table, which is not used in case of non-DT.

All new platforms are DT-only, and none of the old platforms use this
driver, so it does not matter.

	Arnd
