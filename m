From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 24 Apr 2012 12:48:49 +0100
Subject: [PATCH V3 2/2] watchdog: mpcore: Add DT probing support for ARM
 mpcore watchdog
In-Reply-To: <4F9681D4.9010904@st.com>
References: <31b0b89e21e6a234cb904761a1d0e5106405da82.1335246446.git.viresh.kumar@st.com>
 <27dea103ccf6da5b7376c837d9a95dc7a9ed3be3.1335246446.git.viresh.kumar@st.com>
 <4F9671D8.4080308@arm.com> <4F9681D4.9010904@st.com>
Message-ID: <4F969321.1090406@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/12 11:35, Viresh Kumar wrote:
> On 4/24/2012 2:56 PM, Marc Zyngier wrote:
>> I'm sorry, but I really have to ask: What is the point of adding DT
>> support to this driver when it is obvious that it is already broken?
> 
> Interrupt is only for testing. And that's why it worked for me earlier,
> as i didn't passed irq from DT.
> 
> So, i believe this patch still makes sense. Obviously we can have another
> patch to get interrupts fixed.

That's exactly what I object to. You're giving a false sense of
usability ("see, this driver is maintained, it even has DT support!"),
while the damn thing has not worked for quite a long time. And I don't
mean only the interrupt. The driver is not working properly on an SMP
system.

At that point, and unless someone is willing to step up and fix it, I'd
rather make it depend on CONFIG_BROKEN.

	M.
-- 
Jazz is not dead. It just smells funny...
