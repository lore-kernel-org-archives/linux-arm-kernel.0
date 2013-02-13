From: davem@davemloft.net (David Miller)
Date: Wed, 13 Feb 2013 14:02:22 -0500 (EST)
Subject: [PATCH] ARM: net: bpf_jit: fix emit_swap16() for non ARMv6+.
In-Reply-To: <1360776645-14726-1-git-send-email-nschichan@freebox.fr>
References: <1360776125-14542-1-git-send-email-nschichan@freebox.fr>
 <1360776645-14726-1-git-send-email-nschichan@freebox.fr>
Message-ID: <20130213.140222.1699052281796374631.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Schichan <nschichan@freebox.fr>
Date: Wed, 13 Feb 2013 18:30:39 +0100

> The original code was generating an lsl instructions using the value
> of ARM_R8 (skb_headlen, possibly uninitialized if no skb_headlen
> access was required) as a shift amount.
> 
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>

ARM folks do you want to pick this up or would you like me to
apply it to the 'net' tree?
