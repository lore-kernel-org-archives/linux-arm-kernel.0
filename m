From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 28 Apr 2011 12:44:05 +0900
Subject: [PATCH] clkdev: add support to lookup for early platform device
In-Reply-To: <20110428032906.GN29103@game.jcrosoft.org>
References: <20110427084247.GK17290@n2100.arm.linux.org.uk>
	<20110427103145.GF29103@game.jcrosoft.org>
	<20110427104758.GG29103@game.jcrosoft.org>
	<20110427150057.GH29103@game.jcrosoft.org>
	<20110428020910.GA13539@linux-sh.org>
	<20110428024559.GK29103@game.jcrosoft.org>
	<20110428030817.GC13539@linux-sh.org>
	<20110428031704.GL29103@game.jcrosoft.org>
	<20110428032000.GM29103@game.jcrosoft.org>
	<BANLkTiktGTDUvLfmuH-9WgQhdc1e_S4wuQ@mail.gmail.com>
	<20110428032906.GN29103@game.jcrosoft.org>
Message-ID: <BANLkTi=7FAR-KyL+ZEU4MwZpN6xgHE0hzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 12:29 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 12:35 Thu 28 Apr ? ? , Magnus Damm wrote:
>> On Thu, Apr 28, 2011 at 12:20 PM, Jean-Christophe PLAGNIOL-VILLARD
>> <plagnioj@jcrosoft.com> wrote:
>> >> > > > >
>> >> > > > Are you willfully ignoring the init_name handling in
>> >> > > > early_platform_driver_probe_id() or something?
>> >> > > >
>> >> > > > See a636ee7fb35b731ba2b331f6294e809bb6be09c8 for example.
>> >> > > excatly but the issue is that the slab is not availlable yet
>> >> > > see 06fe53beb636294587d8e94ef83c06cef07c21fd
>> >> > > so init_name is still NULL :(
>> >> > >
>> >> > This is a non-argument until you demonstrate a use case where we have a
>> >> > reasonable expectation for the clock framework to be available and the
>> >> > slab allocator not.
>> >> >
>> >> > If you're thinking about the SH earlyprintk case then I suggest you look
>> >> > at the sh-sci driver to see how we presently deal with the situation
>> >> > there.
>> >> the sh-sci driver expect the clock will enable for him
>> >> which did IIRC Magnus on sh-mobile
>> >> I do not want to do so
>> >>
>> >> I've unfortunatly on at91 I use the early device during the map_io
>>
>> But so do we on SH-Mobile ARM.
>>
>> >> so the slab is available and bootmem either
>> > sorry none of theem is available yet
>>
>> Sounds like you are aiming to use earlyprintk a little bit too early,
>> or perhaps your idea of using clocks that early on is what is causing
>> you trouble?
>>
>> Why don't you move down your earlyprintk setup to a time when you have
>> slabs available? Or for clocks, in the sh-sci driver we don't deal
>> with clocks in the earlyprintk case.
>>
>> I understand you want output as early as possible, but there is always
>> going to be a time when you need to hack up some static serial output
>> code.
> I use it for gpio drivers that are init during map_io
>
> so not yet for earlyprintk

You may have explained this before, but why do you need to deal with
that early on?

Can't you simply setup the clocks statically for the early case?

/ magnus
