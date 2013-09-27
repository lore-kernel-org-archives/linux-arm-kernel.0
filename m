From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Sep 2013 11:59:58 +0100
Subject: [RFT PATCH v1 1/7] arm64: fix possible invalid FPSIMD
 initialization state
In-Reply-To: <1380269087-8520-2-git-send-email-liuj97@gmail.com>
References: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
 <1380269087-8520-2-git-send-email-liuj97@gmail.com>
Message-ID: <20130927105957.GB11063@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 09:04:41AM +0100, Jiang Liu wrote:
> From: Jiang Liu <jiang.liu@huawei.com>
> 
> If context switching happens during executing fpsimd_flush_thread(),
> stale value in FPSIMD registers will be saved into current thread's
> fpsimd_state by fpsimd_thread_switch(). That may cause invalid
> initialization state for the new process, so disable preemption
> when executing fpsimd_flush_thread().

Good catch.

-- 
Catalin
