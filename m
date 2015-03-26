From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 26 Mar 2015 11:58:05 +0000
Subject: [PATCH v7 2/7] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <20150326114955.GE8656@n2100.arm.linux.org.uk>
References: <1425466367-30556-1-git-send-email-vincent.yang@socionext.com>
 <1425466884-30648-1-git-send-email-vincent.yang@socionext.com>
 <5513F0D9.5080807@arm.com> <20150326114955.GE8656@n2100.arm.linux.org.uk>
Message-ID: <5513F44D.1060405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/03/15 11:49, Russell King - ARM Linux wrote:
> On Thu, Mar 26, 2015 at 11:43:21AM +0000, Sudeep Holla wrote:
>> I tried using this driver and found that AMBA driver expects apb_clk
>> without which probe fails. Though your example have it, it's not
>> explicit from the binding. Also AMBA binding expects the primecell id in
>> the binding.
>
> That's optional:
>
> Optional properties:
>
> - arm,primecell-periphid : Value to override the h/w value with
>
> It's only required when the hardware doesn't provide the correct value.
>

Ah sorry my bad, I meant the compatible(somehow left this word at the
end of earlier email - it should have been" .. AMBA binding expects the
primecell id in the binding compatible")

- compatible : should be a specific name for the peripheral and
	"arm,primecell". The specific name will match the ARM
	engineering name for the logic block in the form: "arm,pl???"

So I wanted to make sure either we follow that here(unlikely as ARM is
not publishing this as standard primecell yet) or specify that it's
exception here.

Regards,
Sudeep
