From: johannes@sipsolutions.net (Johannes Berg)
Date: Fri, 25 Sep 2015 19:42:25 +0200
Subject: [PATCH V4 1/2] ACPI / EC: Fix broken 64bit big-endian users of
 'global_lock'
In-Reply-To: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 (sfid-20150925_184230_610012_AD3DF607)
References: <e28c4b4deaf766910c366ab87b64325da59c8ad6.1443198783.git.viresh.kumar@linaro.org>
 (sfid-20150925_184230_610012_AD3DF607)
Message-ID: <1443202945.2161.8.camel@sipsolutions.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-09-25 at 09:41 -0700, Viresh Kumar wrote:

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3->V4:
> - Create a local variable instead of changing type of global_lock
>   (Rafael)

Err, surely that wasn't what Rafael meant, since it's clearly
impossible to use a pointer to the stack, assign to it once, and the
expect anything to wkr at all ...

johannes
