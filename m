From: geoff@infradead.org (Geoff Levand)
Date: Thu, 17 Mar 2016 09:47:51 -0700
Subject: [PATCH v15 03/20] arm64: Convert hcalls to use HVC immediate value
In-Reply-To: <56E96920.3090701@arm.com>
References: <cover.1457977401.git.geoff@infradead.org>
 <c23696b455e99b5b111ae559c7998f3c56a664df.1457977402.git.geoff@infradead.org>
 <20160315135030.GA3701@e103592.cambridge.arm.com>
 <1458065710.3391.8.camel@infradead.org>
 <20160316135031.GB3701@e103592.cambridge.arm.com>
 <56E96920.3090701@arm.com>
Message-ID: <1458233271.3391.40.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Wed, 2016-03-16 at 14:09 +0000, Marc Zyngier wrote:
> This seems to go in a direction that is diametrically opposite the
> the
> "normal" ARM way. That doesn't make it an invalid approach, but
> uniformity with other APIs (PSCI for example) and the 32bit KVM code
> seems a highly desirable feature (given that I'll end up maintaining
> that code).

We need a way to get the CPU back to the exception level it had on
entry to the kernel, and this hcall change is part of my proposed
solution.  If you could outline something you think would be a better
fit, I'll take that and work on an implementation of it.

-Geoff
