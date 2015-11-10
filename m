From: yang.shi@linaro.org (Yang Shi)
Date: Tue, 10 Nov 2015 14:41:39 -0800
Subject: [PATCH 0/2] arm64: bpf: add BPF_ST and BPF_XADD instructions support
Message-ID: <1447195301-16757-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Current ARM64 BPF JIT doesn't have store immediate and XADD instructions
support, and aarch64 doesn't have native instructions for them. Implement
them in instruction sequence. For detail, please refer to the commit log.

The implementation is tested by test_bpf kernel module.

The patches are applied after my BPF JIT stack fix [1].

[1] https://patches.linaro.org/56268/

Yang Shi (2):
      arm64: bpf: add 'store immediate' instruction
      arm64: bpf: add BPF XADD instruction

 arch/arm64/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)
