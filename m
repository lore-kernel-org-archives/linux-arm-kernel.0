From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 13 Jun 2012 15:07:36 +0200
Subject: [RFC 3/4] ARM: topology: Update cpu_power according to DT
 information
In-Reply-To: <1339502524-10265-4-git-send-email-vincent.guittot@linaro.org>
References: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
 <1339502524-10265-4-git-send-email-vincent.guittot@linaro.org>
Message-ID: <1339592856.8980.33.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-12 at 14:02 +0200, Vincent Guittot wrote:
> +struct cpu_capacity cpu_capacity[NR_CPUS];

I know ARM isn't likely to suffer from the 4k cpu issue, but is there a
reason to use a NR_CPUS array over a per-cpu variable?
