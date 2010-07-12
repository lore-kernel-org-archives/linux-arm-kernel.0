From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 12 Jul 2010 13:48:31 +0530
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100712080740.GB22138@n2100.arm.linux.org.uk>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>	<20100709124050.GF22845@n2100.arm.linux.org.uk>	<4C3A950F.5040900@st.com>
	<20100712080740.GB22138@n2100.arm.linux.org.uk>
Message-ID: <4C3ACFD7.2060709@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/12/2010 1:37 PM, Russell King - ARM Linux wrote:
> On Mon, Jul 12, 2010 at 09:37:43AM +0530, Viresh KUMAR wrote:
>> > This issue is different from the issue i raised which was common to
>> > all amba devices. This is just for this GPIO driver, we need to enable clk
>> > before using any gpio pin.
> PL061 does not have any other clock signal other than PCLK, the APB (AMBA
> peripheral bus) clock.  This clock needs to be running to access any
> register in an APB peripheral.  The primecell drivers and AMBA support
> is currently implemented with the assumtion that this clock is
> permanently running.
> 
> If you need to enable a clock before using any GPIO pin, and it's not the
> APB clock, then that's a platform extension that is outside of the PL061
> domain, and probably also affects alternate functions of the GPIO pins as
> well.  That means the PL061 code shouldn't manage that clock signal as it
> won't know what's going on with the alternate functions.
> 

Russell,

I agree that this clock is outside of GPIO's domain, but this is how it
is done for all other amba and non amba devices too, like pl011, pl022,
etc. There also we are handling platform specific clocks in drivers only.

Am i missing something??

viresh.
