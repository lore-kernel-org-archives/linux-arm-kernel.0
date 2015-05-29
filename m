From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 29 May 2015 09:14:49 +0200
Subject: [RFC PATCH 1/5] livepatch: ftrace: arm64: Add support for
 DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <1432792265-24076-2-git-send-email-huawei.libin@huawei.com>
References: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
 <1432792265-24076-2-git-send-email-huawei.libin@huawei.com>
Message-ID: <1432883689.3551.3.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-28 at 13:51 +0800, Li Bin wrote:
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig

>  	select HAVE_DYNAMIC_FTRACE
> +	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE

What's the point of "if HAVE_DYNAMIC_FTRACE" here? That test should
always evaluate to true, because HAVE_DYNAMIC_FTRACE is also selected.


Paul Bolle
