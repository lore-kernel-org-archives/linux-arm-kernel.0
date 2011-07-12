From: sjg@chromium.org (Simon Glass)
Date: Mon, 11 Jul 2011 17:01:22 -0700
Subject: [PATCH v4] ARM: Use generic BUG() handler
In-Reply-To: <20110707092802.GA2486@arm.com>
References: <1302822031-6752-1-git-send-email-sjg@chromium.org>
	<4DA7A914.5020804@codeaurora.org>
	<BANLkTikcY-xzjd0W77UfWWoO8ibjKNXQGg@mail.gmail.com>
	<BANLkTin_TpzdQS96SPKUNye6vb2b55Qc4A@mail.gmail.com>
	<143ea9b1bb96e613d534caa7cb3a1e2d.squirrel@www.codeaurora.org>
	<20110426014741.GB28721@quad.lixom.net>
	<BANLkTikHT2E=76jMLbzmQm_CiUw8rA3cCA@mail.gmail.com>
	<20110706200607.GS8286@n2100.arm.linux.org.uk>
	<20110707092802.GA2486@arm.com>
Message-ID: <CAPnjgZ1-wPW1WyR0nC1R5BkLSwc54evb5gV0dpSEOM4duS4omg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Resent, without html, sorry]

Hi Russell & Dave,

On Thu, Jul 7, 2011 at 2:28 AM, Dave Martin <dave.martin@linaro.org> wrote:
> On Wed, Jul 06, 2011 at 09:06:07PM +0100, Russell King - ARM Linux wrote:
>>
>> Sorry, I've finally got back to looking at this.
>>
>> + ? ? ? ? ? ? ? ".pushsection .rodata.str, \"aMS\", 1\n" ? ? ? ?\
>>
>> According to my gas manual:
>>
>> | 7.88 `.pushsection NAME [, SUBSECTION] [, "FLAGS"[, @TYPE[,ARGUMENTS]]]'
>> | ...
[snip]
>> It appears that the TYPE argument is missing. ?As the GAS manual says
>> its required, then I think it really ought to be there. ?Any comment?
>
> I guess type should be %progbits. ?That's what the compiler generates for
> the assembler input in similar situations.
>
> Interestingly, gas does not require this argument and seems to default to
> progbits anyway ... but it seems best to do what the manual says.
>

Thanks for this. I will update the patch and resend to the list.

Regards,
Simon

> Cheers
> ---Dave
>
