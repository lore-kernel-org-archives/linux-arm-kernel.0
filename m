From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 8 Apr 2013 17:13:53 +0100
Subject: some question about monitor mode support in arm
In-Reply-To: <CANudz+tPrFxUEhzbpdVYnhnzKnJJ2wsJ7s_3YAWiOUJjJhQ3YA@mail.gmail.com>
References: <CANudz+tPrFxUEhzbpdVYnhnzKnJJ2wsJ7s_3YAWiOUJjJhQ3YA@mail.gmail.com>
Message-ID: <20130408161353.GA2176@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 14, 2013 at 05:43:30PM +0800, loody wrote:
> Hi all:
> Does linux kernel support monitor mode handling?

No.  In theory the kernel could make use of TrustZone if it is not
locked down by vendor firmware ... but it is hard to make effective
use of it in a large general-purpose software stack like the Linux
kernel.

In consumer devices, TrustZone is often locked down by vendor
firmware, and then Linux can't play with it anyway.


> I grep the keyword 'smc' but it only show how switch to, such as
> mach-highbank/smc.S,
> but not seem where to handle it.

What are you trying to achieve?

Cheers
---Dave
