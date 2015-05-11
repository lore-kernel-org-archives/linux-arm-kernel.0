From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 11 May 2015 10:00:09 -0700
Subject: [PATCH/RFC] PM / Domains: Minimize latencies by not delaying
 save/restore
In-Reply-To: <1431350673-871-1-git-send-email-ulf.hansson@linaro.org> (Ulf
 Hansson's message of "Mon, 11 May 2015 15:24:33 +0200")
References: <1431350673-871-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <7hbnhrdp7q.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

[...]

> To address these two issues, let's change the policy in genpd. More
> precisely, let's walk the hierarchy of the ->runtime_suspend()
> callbacks immediately when genpd's ->runtime_suspend() callback at the
> PM domain level is invoked.

To help in understanding this change, you might also consider leading
with something like this paragraph.  IOW, start with an intro pargraph
about *what* you are changing, and then go into the why.  

The current changlog goes into great detail about "why" before ever
explaining the "what". 

Kevin
