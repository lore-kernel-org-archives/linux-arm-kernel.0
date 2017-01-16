From: qiyaoltc@gmail.com (Yao Qi)
Date: Mon, 16 Jan 2017 12:20:38 +0000
Subject: [RFC PATCH 08/10] arm64/sve: ptrace: Wire up vector length
 control and reporting
In-Reply-To: <1484220369-23970-9-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-9-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170116122038.GG28060@E107787-LIN>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-01-12 11:26:07, Dave Martin wrote:
> This patch adds support for manipulating a task's vector length at
> runtime via ptrace.
> 

I hope kernel doesn't provide such interface to ptracer to change vector
length.  The vector length is sort of a read-only property of thread/process/
program to debugger, unless we really have a clear requirement to modify
vector length in debugging.  I may miss something because I haven't debug
SVE code yet.

> As a simplification, we turn the task back into an FPSIMD-only task
> when changing the vector length.  If the register data is written
> too, we then turn the task back into an SVE task, with changed
> task_struct layout for the SVE data, before the actual data writing
> is done.
> 
> Because the vector length is now variable, sve_get() now needs to
> return the real maximum for user_sve_header.max_vl, since .vl may
> be less than this (that's the whole point).
> 

-- 
Yao (??)
