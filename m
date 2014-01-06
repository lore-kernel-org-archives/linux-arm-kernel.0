From: will.deacon@arm.com (Will Deacon)
Date: Mon, 6 Jan 2014 11:37:23 +0000
Subject: Question: MMU400 support in ARMv7 without CONFIG_ARM_LPAE
In-Reply-To: <CAELmckmcXA42=Mq9bjKbfZpmORULpz2SnLCQqV4zEWTkRH=Qhw@mail.gmail.com>
References: <CAELmckmcXA42=Mq9bjKbfZpmORULpz2SnLCQqV4zEWTkRH=Qhw@mail.gmail.com>
Message-ID: <20140106113723.GF1475@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 02:16:36AM +0000, Bin Wang wrote:
> I found the arm-smmu driver depends on ARM64 || (ARM_LPAE && OF). But in my system, it's and ARMv7 processor, and CONFIG_ARM_LPAE not configured, so not able to use this driver directly.
> 
> Do you have plan to make this driver support ARMv7 without CONFIG_ARM_LPAE?

No. The driver is designed to be portable between arm and arm64 (the latter
only supports long-descriptor), so I didn't bother with short descriptor.
Furthermore, you can't use the short-descriptor format at stage-2, so the
driver would get very ugly indeed.

What's the problem with long-descriptor?

Will
