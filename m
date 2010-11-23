From: per.fransson.ml@gmail.com (Per Fransson)
Date: Tue, 23 Nov 2010 11:57:00 +0100
Subject: [PATCH] Add call to non-crashing cores through IPI
In-Reply-To: <AANLkTimC04kAFws0rAyvfARauiNvyYriJnxJ6KH+UHtU@mail.gmail.com>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
	<AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
	<20101122104740.GA30744@n2100.arm.linux.org.uk>
	<20101122112759.GA31227@n2100.arm.linux.org.uk>
	<AANLkTi=jXuupD+_t663_8haxgB-7Agf7UVcnjBQk+Z-Y@mail.gmail.com>
	<20101122144040.GM31227@n2100.arm.linux.org.uk>
	<AANLkTinj5wnP4823bacK6rs3nQbw3qtqDDjYof2-ALUk@mail.gmail.com>
	<AANLkTi=Ok09NjwZQCb5njqgLfT=K8Zd2fK1VteRb_MNv@mail.gmail.com>
	<AANLkTimTXfeAiRcO0mUp8DsTB5BSCe+94-QH-Kht0AR6@mail.gmail.com>
	<AANLkTimC04kAFws0rAyvfARauiNvyYriJnxJ6KH+UHtU@mail.gmail.com>
Message-ID: <AANLkTikh11_Mx6Z2po9t3RDp68te5o5LdnR0hYOexF=T@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Am I right that deadlock can occur only if the same IPI was sent?
>
> Not necessarily. It depends on whether the CPU issuing the IPI needs
> to wait for the completion of the cross-call. If you don't need to
> wait, you can send the IPI with the interrupts disabled (the platform
> smp_cross_call is already called with interrupts disabled).
>

Well, smp_call_function() only optionally waits. As long as we choose not to,
using that function to ask the other cores to save their states and idle, should
be ok, right? In that case we don't need another ipi_msg_type and we can do
it with the interrupts of the ipi caller disabled.

/Per
