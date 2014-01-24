From: adrienverge@gmail.com (=?UTF-8?Q?Adrien_Verg=C3=A9?=)
Date: Fri, 24 Jan 2014 14:34:41 -0500
Subject: [PATCH V2 4/6] ARM: Make PID_IN_CONTEXTIDR incompatible with
 PID_NS
In-Reply-To: <52E2A866.1050400@codeaurora.org>
References: <1390581656-16372-1-git-send-email-adrienverge@gmail.com>
 <1390581656-16372-5-git-send-email-adrienverge@gmail.com>
 <20140124164343.GJ31040@mudshark.cambridge.arm.com>
 <CANsc=4UgWrFis6hi-0mXZAfery7YGDJ2F+NdZBzq6afwx_i58A@mail.gmail.com>
 <20140124171754.GM31040@mudshark.cambridge.arm.com>
 <52E2A866.1050400@codeaurora.org>
Message-ID: <CANsc=4X+8He-w9wr0xbtDkJhxw8H13kk_-OV07jMZ7govTnmxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014/1/24 Will Deacon <will.deacon@arm.com>:
> I think I'd rather have the global ID than disable a potentially useful
> feature, especially since this is likely to be consumed by external trace
> tools as opposed to user-space tasks.

I understand.

2014/1/24 Christopher Covington <cov@codeaurora.org>:
> Would it be reasonable to make what's
> written to the CONTEXTIDR run-time configurable? If so, what would be the best
> interface for configuring it?

This is an interesting option.

An other option would be to keep the global PID in the Context ID
register, and rely on kernel support to translate virtual PID to
global PID when needed. Then, it would be possible to select a task to
trace via its PID, by asking the kernel to write its global ID to the
Context ID comparator.
