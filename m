From: ccross@google.com (Colin Cross)
Date: Fri, 22 Apr 2011 14:18:06 -0700
Subject: Common clock and dvfs
In-Reply-To: <20110422203526.GC4768@sirena.org.uk>
References: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>
	<20110422194027.GB4768@sirena.org.uk>
	<BANLkTin9mbGKAMB4Bgd=5th+6FgS9gMCtA@mail.gmail.com>
	<20110422203526.GC4768@sirena.org.uk>
Message-ID: <BANLkTikhAiujU=Fmpvp-hWAeoTBNXZoEEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2011 at 1:35 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Apr 22, 2011 at 12:48:37PM -0700, Colin Cross wrote:
>> On Fri, Apr 22, 2011 at 12:40 PM, Mark Brown
>
>> > This sounds like it assumes a 1:1 mapping between clocks and supplies
>> > which is going to break at some point. ?It should be handlable but will
>> > add complexity.
>
>> Almost every platform requires a many-to-one mapping between clocks
>> and supplies (many clocks fed off one supply), and I bet at least one
>> platform has one clock that requires changing two supplies, so a
>
> In most of the platforms I've looked at the supported configurations are
> specified en masse as operating points so it definitely ends up being
> the case, you get a set of frequencies and a set of voltages specified
> as a block.

I see.  Do you happen to know if there are any max voltage
requirements for clocks?  Would running one clock in a group at a low
operating point and another at a high operating point cause a problem,
assuming the voltage is set to what is required by the high operating
point?
