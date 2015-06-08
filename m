From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 08 Jun 2015 14:33:48 -0700
Subject: [PATCH v2 1/2] ARM: Add cpu_resume_arm() for firmwares that
 resume in ARM state
In-Reply-To: <20150603001120.GA4534@codeaurora.org> (Stephen Boyd's message of
 "Tue, 2 Jun 2015 17:11:20 -0700")
References: <1433272378-8470-1-git-send-email-sboyd@codeaurora.org>
 <1433272378-8470-2-git-send-email-sboyd@codeaurora.org>
 <20150602234048.GA7557@n2100.arm.linux.org.uk>
 <20150603001120.GA4534@codeaurora.org>
Message-ID: <7h3821ubpf.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 06/03, Russell King - ARM Linux wrote:
>> On Tue, Jun 02, 2015 at 12:12:57PM -0700, Stephen Boyd wrote:
>> > Some platforms always enter the kernel in the ARM state even if
>> > the kernel is compiled for THUMB2. Add a small wrapper on top of
>> > cpu_resume() that switches into THUMB2 state.
>> > 
>> > This fixes a problem reported by Kevin Hilman on next-20150601
>> > where the ifc6410 fails to boot a THUMB2 kernel because the
>> > platform's firmware always enters the kernel in ARM mode from
>> > deep idle states.
>> 
>> I think this bit of the commit message isn't quite correct: this will
>> only resolve the boot problem with a T2 kernel when the failing platform
>> is converted to use the cpu_resume_arm() entry point.
>> 
>> Apart from that, the patch looks good to me, thanks.
>
> Sure, it could say "This provides the functionality to fix a problem
> reported by..."

Stephen, are you planning to submit this through Russell's patch
tracker?  or...

Russell, should we take this through arm-soc along with PATCH 2/2 which
depends on this one?

Kevin
