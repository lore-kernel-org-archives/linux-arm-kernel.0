From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 May 2017 22:34:55 +0200
Subject: [PATCH] RFC: arm: eBPF JIT compiler
In-Reply-To: <1495564433-9750-1-git-send-email-illusionist.neo@gmail.com>
References: <1495564433-9750-1-git-send-email-illusionist.neo@gmail.com>
Message-ID: <20170523203455.GF24807@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 12:03:53AM +0530, Shubham Bansal wrote:
> The JIT compiler emits ARM 32 bit instructions. Currently, It supports
> eBPF only. Classic BPF is supported because of the conversion by BPF
> core.
> 
> JIT is enabled with
> 
> 	echo 1 > /proc/sys/net/core/bpf_jit_enable
> 
> Constant Blinding can be enabled along with JIT using
> 
> 	echo 1 > /proc/sys/net/core/bpf_jit_enable
> 	echo 2 > /proc/sys/net/core/bpf_jit_harden
> 
> See Documentation/networking/filter.txt for more information.
> Tested on ARMv7 with CONFIG_FRAME_POINTER enabled.
> 
> Results:
> 
> 1. Interpreter:
> 
> 	[   93.551176] test_bpf: Summary: 314 PASSED, 0 FAILED, [0/306 JIT'ed]
> 
> 2. JIT enabled:
> 
> 	[   92.913931] test_bpf: Summary: 314 PASSED, 0 FAILED, [278/306 JIT'ed]
> 
> 3. JIT + blinding enabled:
> 
> 	[  109.414506] test_bpf: Summary: 314 PASSED, 0 FAILED, [278/306 JIT'ed]

Hi Shubham

Is there a HOWTO or a README somewhere about running the tests? I have
a few ARMv5 platforms i can run tests on.

  Thanks
	Andrew
