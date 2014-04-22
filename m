From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 22 Apr 2014 10:53:07 +0100
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <20140417213502.GX24070@n2100.arm.linux.org.uk>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <CAL_Jsq+aYXTQCzCtxPnS=zhBCba6-mEz+kT-mHTDW602E0vbDw@mail.gmail.com>
 <alpine.LFD.2.11.1404171549480.980@knanqh.ubzr>
 <20140417201645.GU24070@n2100.arm.linux.org.uk>
 <CAL_JsqL65bXBh1_dcud6XaDqFBnY1L69dMXWeNHvFAvcDizzhQ@mail.gmail.com>
 <20140417213502.GX24070@n2100.arm.linux.org.uk>
Message-ID: <53563C03.7090401@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/14 22:35, Russell King - ARM Linux wrote:
> On Thu, Apr 17, 2014 at 04:18:45PM -0500, Rob Herring wrote:
>> The problem here is more than just the TEXT_OFFSET changed. From what
>> I've heard, there are some QC chips which need much more reserved RAM
>> than the 2MB discussed here. Changing the TEXT_OFFSET is a hack that
>> doesn't scale.
> 
> You may think it's a hack, but we really can't get around this.  There
> really are platforms out there where we must do this kind of stuff.  I
> invite you next time you meet up to talk to Michal Simek.  There's no
> way they can load the kernel at 32K into RAM.

After reading this thread I have noticed that the sort order for the
textofs part of this makefile is numeric (based on textofs) rather than
alphabetic.

Is this an intentional mechanism? Certainly the result of numeric
sorting is that the kernel will rise to the highest point in memory that
suits all enabled platforms (based on the assumption that platforms are
much more likely to reserve memory right at the start of RAM than
slightly offset into it).

If so would you welcome a comment only patch explaining this?
