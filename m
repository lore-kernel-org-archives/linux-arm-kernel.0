From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 12 May 2018 10:29:57 -0700
Subject: [BUGFIX PATCH v3 0/4] arm: kprobes: Fix to prohibit probing on
 unsafe functions
In-Reply-To: <20180512203137.4c00f301c4359de1f6253154@kernel.org>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
 <20180508112503.GD16141@n2100.armlinux.org.uk>
 <20180512203137.4c00f301c4359de1f6253154@kernel.org>
Message-ID: <59CD6F84-9E51-469B-BB67-340A4F376A13@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 12, 2018 4:31:37 AM PDT, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>Hi Russell,
>
>On Tue, 8 May 2018 12:25:03 +0100
>Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>
>> On Fri, May 04, 2018 at 01:14:31PM +0900, Masami Hiramatsu wrote:
>> > Hi,
>> > 
>> > This is the 3rd version of bugfix series for kprobes on arm.
>> > This series fixes 4 different issues which I found.
>> > 
>> >  - Fix to use smp_processor_id() after disabling preemption.
>> >  - Prohibit probing on optimized_callback() for avoiding
>> >    recursive probe.
>> >  - Prohibit kprobes on do_undefinstr() by same reason.
>> >  - Prohibit kprobes on get_user() by same reason.
>> > 
>> > >From v2, I included another 2 bugfixes (1/4 and 2/4)
>> > which are not merged yet, and added "Cc: stable at vger.kernel.org",
>> > since there are obvious bugs.
>> 
>> Please submit them to the patch system, thanks.
>
>Could you tell me what you mean the patch system?

This is in Russell's signature:

RMK's Patch system: http://www.armlinux.org.uk/developer/patches/

-- 
Florian
