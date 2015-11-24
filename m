From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 24 Nov 2015 12:10:02 +0000
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <20151124104225.GA8644@n2100.arm.linux.org.uk> (Russell King's
 message of "Tue, 24 Nov 2015 10:42:26 +0000")
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <20151124001306.GI19156@codeaurora.org>
 <20151124085349.GQ19156@codeaurora.org> <4485320.CGMJdfZLya@wuerfel>
 <20151124104225.GA8644@n2100.arm.linux.org.uk>
Message-ID: <yw1xsi3vr42t.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Tue, Nov 24, 2015 at 11:38:53AM +0100, Arnd Bergmann wrote:
>> I suggested using -mcpu=cortex-a15 because there are old gcc versions
>> that don't know about -march=armv7ve or -march=armv7-a+idiv yet, but
>> that do understand -mcpu=cortex-a15.
>
> That's not all.  The bigger problem is that there are toolchains out
> there which accept these options, but do _not_ support IDIV in either
> ARM or Thumb mode.  I'm afraid that makes it impossible to add this
> feature to the mainline kernel in this form: we need to run a test
> build to check that -march=armv7ve or what-not really does work
> through both GCC and GAS.

If the compiler accepts the option but doesn't actually emit any div
instructions, is there any real harm?

-- 
M?ns Rullg?rd
mans at mansr.com
