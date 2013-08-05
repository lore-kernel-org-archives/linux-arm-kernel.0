From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Aug 2013 09:45:05 -0700
Subject: [PATCH 0/3] ARM: vexpress: TC2 MCPM/SPC cleanups
In-Reply-To: <20130805094709.GA29090@e102568-lin.cambridge.arm.com>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
 <20130805094709.GA29090@e102568-lin.cambridge.arm.com>
Message-ID: <CAOesGMjGqFfHhdUfd98ps5Sc_Z7Nsn2OpMBPbCHtfTkEeCYWKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 5, 2013 at 2:47 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Mon, Aug 05, 2013 at 05:09:50AM +0100, Olof Johansson wrote:
>> Here's a short series on top of Nico's TC2 MCPM series to move the SPC driver
>> back under mach-vexpress where it should be, and a couple of tiny cleanups
>> to the driver.
>>
>> I'll pick this up together with the base branch in arm-soc for-next, but I
>> haven't staged it in a next/* branch so it can be rebased/changed/dropped
>> if needed.
>>
>> There's still one thing left to iron out, and that's the actual binding
>> for the "SPC" node. Since the spc code needs a non-zero SPC_BASE, it
>> implies that there's more than just SPC described by the device node. So
>> either the naming and description needs to be changed, or there's need
>> for more than one device node to describe the other register ranges. The
>> former might be easier in this case...
>>
>> Pawel, I'd appreciate a quick test from you to make sure I didn't break
>> anything since I don't have a way to boot this myself.
>
> Thanks Olof.
>
> Tested, a couple of fixes needed to compile your series, comments in the
> relative patches.

Thanks. For some reason I figured vexpress_defconfig would provide
build coverage, so it obviously missed build coverage by me. I also
missed a git add.

> For the bindings, you are right, how about this (commit log written just
> for the sake of it, it should be squashed in Nico's original series) ?

There's no harm in keeping the change history by having two patches.
I'll add this below my series of three when I revise them.



-Olof
