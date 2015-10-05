From: davem@davemloft.net (David Miller)
Date: Mon, 05 Oct 2015 07:01:55 -0700 (PDT)
Subject: [PATCH net] ARM: net: make BPF_LD | BPF_IND instruction
 trigger r_X initialisation to 0.
In-Reply-To: <1443793152-8661-1-git-send-email-nschichan@freebox.fr>
References: <1443793152-8661-1-git-send-email-nschichan@freebox.fr>
Message-ID: <20151005.070155.1958954047126197017.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Schichan <nschichan@freebox.fr>
Date: Fri,  2 Oct 2015 15:39:12 +0200

> Without this patch, if the only instructions using r_X are of the
> BPF_LD | BPF_IND type, r_X would not be reset to 0, using whatever
> value was there when entering the jited code. With this patch, r_X
> will be correctly marked as used so it will be reset to 0 in the
> prologue code.
> 
> This fix also makes the test "LD_IND byte default X" pass in the
> test_bpf module when the ARM JIT is enabled.
> 
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>

Applied.
