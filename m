From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 11 Nov 2014 18:05:23 +0000
Subject: error detecting cacheinfo
In-Reply-To: <CAOMZO5Af6Rh7zDBGu7cNarENV-+Pr5CWaj7HZMXKq9_QCGk7tg@mail.gmail.com>
References: <CAOMZO5Af6Rh7zDBGu7cNarENV-+Pr5CWaj7HZMXKq9_QCGk7tg@mail.gmail.com>
Message-ID: <54624FE3.1090109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/11/14 16:52, Fabio Estevam wrote:
> Sudeep,
>
> I am running linux-next 20141111 and since commit 246246cbde5e ("
> drivers: base: support cpu cache information interface to userspace
> via sysfs") I am getting the following error on a mx6:
>
> [    1.253691] error detecting cacheinfo..cpu0
>
> What would be the correct way to fix this error?
>

Sorry for that. I think it should be changed to debug as it's noisy in
boot message. I will post a patch to silence that and check if Greg can
pick up this.

Since the changes in my original series[1] are across multiple
architectures (some of them is yet test), I asked Greg to pull only the
core support. I have the architecture specific patches 5-11 to follow
which I am targeting v3.20.

Regards,
Sudeep

[1] https://lkml.org/lkml/2014/9/30/347
