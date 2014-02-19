From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 19 Feb 2014 15:18:08 +0530
Subject: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded irq
 handler
In-Reply-To: <20140219094322.GR21483@n2100.arm.linux.org.uk>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
 <E1WFmIk-0006m0-Ah@rmk-PC.arm.linux.org.uk>
 <20140218175703.GJ21483@n2100.arm.linux.org.uk>
 <CAKohpoknX=acZHJeydwv6XRKFHTD4DM84xfCJ=56NrRfJnBOOA@mail.gmail.com>
 <20140219094322.GR21483@n2100.arm.linux.org.uk>
Message-ID: <CAKohpomfHxWBF5m4D6iqod4a3gw2BU1W6nXMkEOg+YA+izYr=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 February 2014 15:13, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Feb 19, 2014 at 11:43:19AM +0530, Viresh Kumar wrote:
>> Adding ST people as well who have access to boards and are working on SPEAr.
>>
>> On 18 February 2014 23:27, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > 1) You're controlling the card power GPIO via the insertion/removal
>> >    interrupt handler?  What's wrong with using a vmmc regulator for
>> >    that, which will be controlled via the MMC subsystem as required?
>>
>> Haven't explored that earlier.. Maybe its possible but no idea.
>> The requirements were like this:
>> - We may or maynot need a GPIO for controlling power
>> - If we need it, we may need to disable/enable power with card removal/
>> insertion Or we may need to keep it enabled for ever..
>
> So how is this any different from any other system which controls power to
> the MMC/SD socket?

I am not claiming it to be different. I am just saying these were the
requirements
and I am not sure if they were satisfied with vmmc regulator. It might
be exactly
same in all other platforms.
