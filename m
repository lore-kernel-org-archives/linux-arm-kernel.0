From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Mon, 26 Dec 2011 15:08:08 +0400
Subject: [PATCH] arm: oprofile: fix linkage issue
In-Reply-To: <1324561016-19389-1-git-send-email-vladimir.zapolskiy@nokia.com>
References: <1324561016-19389-1-git-send-email-vladimir.zapolskiy@nokia.com>
Message-ID: <4EF85598.30705@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 22-12-2011 17:36, Vladimir Zapolskiy wrote:

> This change fixes a linking problem, which happens if oprofile is selected to
> be compiled as built-in:

>    `oprofile_arch_exit' referenced in section `.init.text' of
>    arch/arm/oprofile/built-in.o: defined in discarded section
>    `.exit.text' of arch/arm/oprofile/built-in.o

> The problem is

    s/is/has/

> appeared after commit 87121ca504, which introduced

    Please also specify that commit's summary in parens.

> oprofile_arch_exit() calls from __init function. Note that the aforementioned
> commit has been backported to stable branches, and the problem is known to be
> reproduced at least with 3.0.13 and 3.1.5 kernels.

> Signed-off-by: Vladimir Zapolskiy<vladimir.zapolskiy@nokia.com>
> Cc: Will Deacon<will.deacon@arm.com>
> Cc: Robert Richter<robert.richter@amd.com>
> Cc: stable at kernel.org

WBR, Sergei
