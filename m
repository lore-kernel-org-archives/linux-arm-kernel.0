From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Feb 2013 12:58:03 +0000
Subject: [PATCH] arm64: compat_sys_sigsuspend: init local blocked mask
 not current process mask
In-Reply-To: <1361796007-20143-1-git-send-email-ryan.harkin@linaro.org>
References: <1361796007-20143-1-git-send-email-ryan.harkin@linaro.org>
Message-ID: <20130225125803.GB28172@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 25, 2013 at 12:40:07PM +0000, Ryan Harkin wrote:
> The original version changed the signal mask in the current process,
> and then passed an unitialized variable to sigsuspend, which in turn,
> besides the other work, sets current->blocked.
> 
> The value of mask, passed from a process, was effectively overwritten
> by some random value.  If the random value was zero, all signals were
> blocked and pipes no longer work.
> 
> Signed-off-by: Ryan Harkin <ryan.harkin@linaro.org>

Thanks for the patch. It's a candidate for stable since mainline no
longer has this function, removed by commit 84b9e9b40 (arm64: switch
compat to generic old sigsuspend).

-- 
Catalin
