From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 10:33:37 -0700
Subject: [PATCH RFC 1/3] PM / Domains: Allocate memory outside domain locks
In-Reply-To: <1433456946-53296-2-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Thu, 4 Jun 2015 16:29:04 -0600")
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-2-git-send-email-lina.iyer@linaro.org>
Message-ID: <7hpp53o4cu.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> In order for domains to be powered on/off in irq locked context, the
> domain locks could either be a spinlock or a mutex, depending on the
> domain. 

I'd drop that sentence.

> In preparation for atomic support, allocate domain data outside

In preparation for supporting IRQ-safe domainss, ...

> the domain locks, so the allocation calls dont have to be context
> sensitive.

OK, but *why* don't these allocations need to be protected by the
locks.  Presumably they were put inside the locks for a reason, so you
should make the case for why the lock protection isn't needed.

Kevin
