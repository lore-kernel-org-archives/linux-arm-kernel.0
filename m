From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 24 Aug 2011 09:45:23 +0800
Subject: [PATCH v2 1/4] ARM: CSR: add rtc i/o bridge interface for
	SiRFprimaII
In-Reply-To: <201108231759.20014.arnd@arndb.de>
References: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
	<CAGsJ_4wpHBYuALijDWpLsmYTiDQddAW1DdE84tY=w4==eiyJhA@mail.gmail.com>
	<20110823095354.GK2796@pulham.picochip.com>
	<201108231759.20014.arnd@arndb.de>
Message-ID: <CAGsJ_4ymeOCckqPQ2Xg81g-6-pgKfcGLfLREmXQ_V7OnEJiMWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/8/23 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 23 August 2011, Jamie Iles wrote:
>> On Tue, Aug 23, 2011 at 05:33:39PM +0800, Barry Song wrote:
>> > 2011/8/23 Jamie Iles <jamie@jamieiles.com>:
>> > > On Mon, Aug 22, 2011 at 11:15:49PM -0700, Barry Song wrote:
>> [...]
>> > >> +void sirfsoc_rtc_iobrg_wait_sync(void)
>> > >> +{
>> > >> + ? ? while (readl_relaxed(sirfsoc_rtciobrg_base + SIRFSOC_CPUIOBRG_CTRL))
>> > >> + ? ? ? ? ? ? continue;
>> > >
>> > > It might be worth using cpu_relax() here as it includes a memory barrier
>> > > that's what many busy wait loops do.
>> >
>> > yes. generically people add a cpu_relax() in busy wait and that makes
>> > lots of senses. it seems readl_relaxed() can keep the execution
>> > sequence even without the barrier?
>>
>> Well readl_relaxed() uses __raw_readl() which marks the dereference as
>> volatile, so you should be okay without the cpu_relax() here. ?Having
>> said that, cpu_relax() is a little more explicit, so whatever you think
>> most appropriate I guess.
>
> I agree with Jamie, mostly because using cpu_relax in busy loops is
> a well-known idiom in the kernel. It's more for documentation purposes
> than technically needed here.

ok

>
> ? ? ? ?Arnd
>
-barry
