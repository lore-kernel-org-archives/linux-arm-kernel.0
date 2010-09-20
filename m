From: robherring2@gmail.com (Rob Herring)
Date: Mon, 20 Sep 2010 09:56:10 -0500
Subject: [PATCH 48/74] GIC: Added dummy handlers for Power Management
	Suspend Resume
In-Reply-To: <20100920134808.GD30793@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>	<47425e7be671c44d949b1804436b5c301d20d793.1283161023.git.viresh.kumar@st.com>	<20100902102323.GP26319@n2100.arm.linux.org.uk>	<4C809486.2070308@st.com>	<20100903073421.GF26319@n2100.arm.linux.org.uk>	<4C84D6B3.80104@st.com>	<20100908151232.GD32659@n2100.arm.linux.org.uk>	<4C885FF2.7060201@st.com>
	<4C976541.6000203@st.com>
	<20100920134808.GD30793@n2100.arm.linux.org.uk>
Message-ID: <4C97760A.60404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2010 08:48 AM, Russell King - ARM Linux wrote:
> On Mon, Sep 20, 2010 at 07:14:33PM +0530, deepaksi wrote:
>> I request you to provide some more inputs on this, so that we can close
>> the issue.
>
> I don't know, especially so without seeing the drivers.

Assuming there is no powergating of the GIC, then this patch should be 
sufficient depending on one question. Whose responsibility is it to 
disable non-wakeup irqs: the interrupt controller code or each driver? 
If drivers are not trusted to disable their interrupt, then GIC 
suspend/resume functions are needed to disable/re-enable non-wakeup irqs.

With powergating of the GIC, saving and restoring of the GIC state in 
addition to external handling of wake-up would be needed.

Rob
