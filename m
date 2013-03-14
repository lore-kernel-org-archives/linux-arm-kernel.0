From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 14 Mar 2013 09:37:28 -0400
Subject: some question about monitor mode support in arm
In-Reply-To: <CANudz+tPrFxUEhzbpdVYnhnzKnJJ2wsJ7s_3YAWiOUJjJhQ3YA@mail.gmail.com>
References: <CANudz+tPrFxUEhzbpdVYnhnzKnJJ2wsJ7s_3YAWiOUJjJhQ3YA@mail.gmail.com>
Message-ID: <5141D298.6010401@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/14/2013 05:43 AM, loody wrote:
> Hi all:
> Does linux kernel support monitor mode handling?

It does not, but hypervisor mode support was recently added, which has pretty
similar mechanics.

> I grep the keyword 'smc' but it only show how switch to, such as
> mach-highbank/smc.S,
> but not seem where to handle it.

You can take a look at __hyp_set_vectors in arch/arm/kernel/hyp-stub.S for one
example of setting up exception vectors.

Cheers,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
