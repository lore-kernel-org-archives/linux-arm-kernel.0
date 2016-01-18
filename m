From: davem@davemloft.net (David Miller)
Date: Sun, 17 Jan 2016 19:15:40 -0500 (EST)
Subject: [PATCH 1/2] arm64: insn: remove BUG_ON from codegen
In-Reply-To: <1452756802-16511-1-git-send-email-zlim.lnx@gmail.com>
References: <1452756802-16511-1-git-send-email-zlim.lnx@gmail.com>
Message-ID: <20160117.191540.973637884089764401.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zi Shen Lim <zlim.lnx@gmail.com>
Date: Wed, 13 Jan 2016 23:33:21 -0800

> During code generation, we used to BUG_ON unknown/unsupported encoding
> or invalid parameters.
> 
> Instead, now we report these as errors and simply return the
> instruction AARCH64_BREAK_FAULT. Users of these codegen helpers should
> check for and handle this failure condition as appropriate.
> 
> Otherwise, unhandled codegen failure will result in trapping at
> run-time due to AARCH64_BREAK_FAULT, which is arguably better than a
> BUG_ON.
> 
> Signed-off-by: Zi Shen Lim <zlim.lnx@gmail.com>

Applied.
