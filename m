From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jun 2011 11:15:36 +0100
Subject: [RFC PATCH v2 0/5] Add generic macros for declaring various
	CPU structs
In-Reply-To: <20110616101241.GA4028@e102144-lin.cambridge.arm.com>
References: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
	<20110616101241.GA4028@e102144-lin.cambridge.arm.com>
Message-ID: <20110616101536.GA32629@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 11:12:41AM +0100, Will Deacon wrote:
> >  * For consistency, I've renamed the arch/CPU name string labels.
> >    If that is seen as unnecessary churn, it can be undone.
> 
> I don't see the win here, so let's leave the names like they are to avoid
> unnecessary conflicts with other patches dealing with proc_info structs.

One of the issues is that there are proc-* files which use the same
strings for several entries, for example, proc-xscale.S.

In general, the ELF name and arch name should be the same across all,
just the CPU name should differ.
