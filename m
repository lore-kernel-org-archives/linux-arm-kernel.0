From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 29 Mar 2010 12:07:19 +0200
Subject: [PATCH 1/7] arch/arm: Use set_cpus_allowed_ptr
In-Reply-To: <Pine.LNX.4.64.1003262301300.6480@ask.diku.dk>
References: <Pine.LNX.4.64.1003262301300.6480@ask.diku.dk>
Message-ID: <1269857239.12097.250.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-03-26 at 23:01 +0100, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Use set_cpus_allowed_ptr rather than set_cpus_allowed.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression E1,E2;
> @@
> 
> - set_cpus_allowed(E1, cpumask_of_cpu(E2))
> + set_cpus_allowed_ptr(E1, cpumask_of(E2))
> 
> @@
> expression E;
> identifier I;
> @@
> 
> - set_cpus_allowed(E, I)
> + set_cpus_allowed_ptr(E, &I)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

Thanks for doing this Julia!
