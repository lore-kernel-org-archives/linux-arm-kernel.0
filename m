From: dmitriyz@google.com (Dima Zavin)
Date: Mon, 10 Jan 2011 14:43:37 -0800
Subject: [PATCH 4/5 v4] msm: convert 7x30 to gpiomux.
In-Reply-To: <1294680810.12298.2.camel@c-dwalke-linux.qualcomm.com>
References: <1283015148-10747-1-git-send-email-gbean@codeaurora.org>
	<1283015148-10747-4-git-send-email-gbean@codeaurora.org>
	<AANLkTikrLnGxNSJgv3KDNAQ5kvjNd8aPrOEBwftiiyrQ@mail.gmail.com>
	<1294680810.12298.2.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <AANLkTi=0e9e1=D9m_cGuGKL+Q7aZEpncWHiLHyVmTad4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Send under different title:
    [PATCH] ARM: msm: 7x30: don't force a gpiomux table for the whole arch

On Mon, Jan 10, 2011 at 9:33 AM, Daniel Walker <dwalker@codeaurora.org> wrote:
> On Sun, 2011-01-09 at 14:53 -0800, Dima Zavin wrote:
>> Greg,
>>
>> Just rebased on top of 2.6.37 and this patch is totally the wrong way
>> to go about this.
>>
>> I should have commented at the appropriate time, so sorry for the late reply.
>>
>> Having this ?msm_gpiomux_configs be always compiled in for all msm7x30
>> devices makes this entire system completely inflexible since you have
>> to modify common code to provide board specific initialization. The
>> definition of "msm_gpiomux_configs" belongs in the board file, not in
>> gpiomux-7x30.c. I think we need to delete this new file and move the
>> definition back into board-msm7x30.c, but just use the new gpiomux
>> APIs.
>>
>> I can provide a patch if you like.
>
> I would just provide the patch .. It would be easier to understand what
> your talking about.
>
> Daniel
>
>
> --
>
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
>
