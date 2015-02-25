From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Feb 2015 13:24:38 +0000
Subject: [RFC PATCH] arm64: Implement cpu_relax as yield
In-Reply-To: <1424819257-22664-1-git-send-email-peter.crosthwaite@xilinx.com>
References: <1424819257-22664-1-git-send-email-peter.crosthwaite@xilinx.com>
Message-ID: <20150225132437.GD12377@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 11:07:37PM +0000, Peter Crosthwaite wrote:
> ARM64 has the yield nop hint which has the intended semantics of
> cpu_relax. Implement.
> 
> The immediate application is ARM CPU emulators. An emulator can take
> advantage of the yield hint to de-prioritise an emulated CPU in favor
> of other emulation tasks. QEMU A64 SMP emulation has yield awareness,
> and sees a significant boot time performance increase with this change.

Could you elaborate on the QEMU SMP boot case please? Usually SMP pens
for booting make use of wfe/sev to minimise the spinning overhead.

Will
