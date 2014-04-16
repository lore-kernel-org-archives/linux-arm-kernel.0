From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Apr 2014 14:48:15 +0100
Subject: [PATCH v7 5/7] arm64: ftrace: Add dynamic ftrace support
In-Reply-To: <1394862353-28963-6-git-send-email-takahiro.akashi@linaro.org>
References: <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>
 <1394862353-28963-6-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140416134815.GE1001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 05:45:51AM +0000, AKASHI Takahiro wrote:
> This patch allows "dynamic ftrace" if CONFIG_DYNAMIC_FTRACE is enabled.
> Here we can turn on and off tracing dynamically per-function base.
> 
> On arm64, this is done by patching single branch instruction to _mcount()
> inserted by gcc -pg option. The branch is replaced to NOP initially at
> kernel start up, and later on, NOP to branch to ftrace_caller() when
> enabled or branch to NOP when disabled.
> Please note that ftrace_caller() is a counterpart of _mcount() in case of
> 'static' ftrace.
> 
> More details on architecture specific requirements are described in
> Documentation/trace/ftrace-design.txt.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
