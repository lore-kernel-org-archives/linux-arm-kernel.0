From: tixy@yxit.co.uk (Tixy)
Date: Tue, 29 Mar 2011 10:12:36 +0100
Subject: [PATCH] kprobes/arm: fix emulation of LDR/STR instruction when
	Rn == PC
In-Reply-To: <4D90B70F.7050108@nokia.com>
References: <1301072519-27937-1-git-send-email-viktor.rosendahl@nokia.com>
	<1301087944.2744.85.camel@computer2.home> <4D90B70F.7050108@nokia.com>
Message-ID: <1301389956.2519.17.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-03-28 at 19:27 +0300, Viktor Rosendahl wrote:
> On 03/25/2011 11:19 PM, ext Tixy wrote:
[...]
> > I don't think it is worth adding code to check for illegal instructions.
> > The toolchain shouldn't generate them in the first place, and there are
> > many places in the kprobe code which doesn't bother checking; there are
> > even comments like "may be invalid, don't care".
> 
> I think those "may be invalid, don't care" comments mostly are about the 
> Rm value, which isn't valid for some fully legal variants of the 
> instruction, those instructions that have the immediate bit set. In that 
> case the Rm value, will actually be part of an immediate and thus bogus. 
> However, it will not impact the result of the emulation because the 
> instruction will not read from the r2 register. It's enough to check the 
> immediate bit in the prep_emulate_*() functions; if you check for 
> example the prep_emulate_ldr_str() function you will se that it actually 
> does it before adjusting Rm to r2.
> 
> To summarize, I think the "may be invalid, don't care" comments simply 
> mean "This value may be bogus but in that case it will not impact the 
> result of the emulation so we don't care".
[...]

Yes, I think you are correct. I jumped to conclusions from just looking
at the comments and not looking at the code carefully enough.

-- 
Tixy
