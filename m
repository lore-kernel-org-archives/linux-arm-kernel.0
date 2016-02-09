From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 9 Feb 2016 10:07:58 -0500
Subject: [PATCH] arm64: replace read_lock to rcu lock in call_step_hook
In-Reply-To: <20160209145426.GR22874@arm.com>
References: <1454971764-30720-1-git-send-email-yang.shi@linaro.org>
 <20160209145426.GR22874@arm.com>
Message-ID: <20160209100758.69d9006f@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Feb 2016 14:54:26 +0000
Will Deacon <will.deacon@arm.com> wrote:


> Acked-by: Will Deacon <will.deacon@arm.com>

Will,

The patch looks good to me. Do you want to take it through your tree?

It benefits mainline too as a rcu_read_lock() is more efficient than
rwlocks. Although I will say this is a slow path anyway.

-- Steve
