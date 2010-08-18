From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 18 Aug 2010 12:48:32 -0700
Subject: [PATCH v2] ARM: uaccess: Implement strict user copy checks
In-Reply-To: <201008181428.45029.arnd@arndb.de>
References: <4C61EE55.5030506@codeaurora.org>
	<1282094950-6184-1-git-send-email-sboyd@codeaurora.org>
	<201008181428.45029.arnd@arndb.de>
Message-ID: <4C6C3910.80800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2010 05:28 AM, Arnd Bergmann wrote:
> On Wednesday 18 August 2010, Stephen Boyd wrote:
>>
>> I'm unsure what needs to be done for the follow up patch. Shouldn't
>> it be multiple patches sent to each arch maintainer to fix the
>> wording?
>
> No, that will just result in half of them applying it, best make
> a single patch and send it to linux-arch at vger.kernel.org for review.
>
> It's probably best to move the config option to lib/Kconfig.debug
> so it only appears once, and make it depend on DEBUG_USER_COPY_CHECKS,
> which is then unconditionally defined by the architectures that want it.

Ok.

So the only sticking point now is that x86, parisc, and arm use warnings 
and errors but s390 only uses warnings. I guess I'll reword it to be:

	Enabling this option turns a certain set of sanity checks for
	user copy operations into compile time warnings/errors.

	The copy_from_user() etc checks are there to help test if there
	are sufficient security checks on the length argument of the
	copy operation, by having gcc prove that the argument is
	within bounds.

	If unsure, or if you run an older (pre 4.4) gcc where this
	option is a no-op, say N.

or I'll add a patch to make s390 trigger an error when this is enabled?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
