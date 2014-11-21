From: grant.likely@linaro.org (Grant Likely)
Date: Fri, 21 Nov 2014 14:58:47 +0000
Subject: [PATCH v5.5] of/fdt: export fdt blob as /sys/firmware/fdt
In-Reply-To: <1416421971.23886.71.camel@smoke>
References: <1415984735-32388-1-git-send-email-ard.biesheuvel@linaro.org>
 <20141118165145.4F6A8C40966@trevor.secretlab.ca>
 <20141118172545.GC14323@leverpostej>
 <20141118221103.4ECB3C40966@trevor.secretlab.ca>
 <1416402576.29243.35.camel@citrix.com>
 <1416421971.23886.71.camel@smoke>
Message-ID: <CACxGe6tGdJOop8m3zVU4DKginT=BxpLFjfV35QX_8JLiUhtZ3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 6:32 PM, Geoff Levand <geoff.levand@linaro.org> wrote:
> Hi Ian,
>
> On Wed, 2014-11-19 at 13:09 +0000, Ian Campbell wrote:
>> On Tue, 2014-11-18 at 22:11 +0000, Grant Likely wrote:
>> > > > * It also helps with exposing the reserved map to userspace, but kexec
>> > > >   has done without that feature for years, and it is in the process of
>> > > >   being deprecated in favour of /reserved-memory anyway.
>> > >
>> > > This is the first I'd heard of the reserve map being deprecated, and
>> > > we're going to have DTs with reserved map entries for a long time going
>> > > forwards.
>> >
>> > Deprecated, not removed or disabled. It will still work pretty much
>> > forever, but users should be encouraged to move to the reserve-memory
>> > tree.
>>
>> I'm curious why that should be for the "OS should never touch this, here
>> be dragons" type memory, what are the benefits of the new scheme in that
>> case?
>
> /memreserve/ device tree entries are not available in /proc/device-tree,
> but reserved-memory nodes are.  Some solution is needed to get all
> reserved memory info into the dtb passed to the second stage kernel
> during a kexec re-boot.

We could also add a file to export the memreserve sections, but now
that we've got the whole DTB exported, I think it should be fine for
that also to be the interface for obtaining memreserve.

g.
