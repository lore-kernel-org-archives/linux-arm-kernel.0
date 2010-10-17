From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sun, 17 Oct 2010 15:06:44 +0300
Subject: [PATCH .36-rc8] arm: mm: allow, but warn, when issuing ioremap()
	on RAM
In-Reply-To: <20101015201453.GB12981@n2100.arm.linux.org.uk>
References: <1287152120-7201-1-git-send-email-felipe.contreras@gmail.com>
	<1287153021.27165.6.camel@e102109-lin.cambridge.arm.com>
	<20101015194255.GA12981@n2100.arm.linux.org.uk>
	<AANLkTinmAy13niqRKrray1Gk4hkr19tA2gWwYbfnFoh7@mail.gmail.com>
	<20101015201453.GB12981@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimyEZp4ygmM7WeES3h5bixBNF2rY0x==x7SZ+GQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 15, 2010 at 11:14 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Oct 15, 2010 at 11:00:40PM +0300, Felipe Contreras wrote:
>> On Fri, Oct 15, 2010 at 10:42 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > As soon as the first ARM merge hits during the merge window, I'll be
>> > restoring the 'always fail' behaviour.
>>
>> Ok, are you going to merge also your patch to use memblock for the
>> initialization? Many drivers could certainly use that to fix the
>> issue.
>
> There's a lot of work going on with memblock in x86-land which impacts
> ARM and means major conflicts for that patch - I think first we'll have
> to deal with the fallout from that (iow, finding out what's been broken
> by this activity and fix that), and then I'll have to re-do my patch from
> the beginning.
>
> Technically, following the rules, that means it has to miss this merge
> window - so it looks like it's going to take another six months to solve
> this issue (three months to get the memblock patch in, and another three
> months for driver fixes to find their way through.)

I don't think that's a good idea. Drivers would not have a way to get
fixed, even for .37.

Are these x86 changes in some branch? Would it help if I try to port
your patch on top of that? IOW; is there any chance of getting these
drivers fixed on .37?

If not, I guess people would have to revert the patch that disables
ioremap() on RAM on their trees.

> I find these timescales (12 months) rather unacceptable to fix a problem
> such as this. ?Makes me wonder why I even bother trying.

As I said, if the warning was merged on .35 (or even before) I think
things would have gone smoother, but I guess we'll see on .36 what
happens.

-- 
Felipe Contreras
