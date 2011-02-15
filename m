From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 15 Feb 2011 23:42:25 +0100
Subject: [RFC] ARM: dma-mapping: outer cache is invalidated twice
In-Reply-To: <20110215154633.GN4152@n2100.arm.linux.org.uk>
References: <AANLkTi=rZJq0CPQD0Q1HMgih7UP0Tqoh9sPEYb2NEV_X@mail.gmail.com>
	<20110215133232.GI4152@n2100.arm.linux.org.uk>
	<20110215134134.GA17208@n2100.arm.linux.org.uk>
	<AANLkTi=Fs5+3yG-_4u0oU8WK4K4FU_8zN38H=RNcgRNU@mail.gmail.com>
	<20110215141253.GJ4152@n2100.arm.linux.org.uk>
	<AANLkTinpcYoHKKDhqy9mKpqOEGtMpNc1BSukNWH-GVBX@mail.gmail.com>
	<20110215154633.GN4152@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim3W5ZXYxW6u7EmZYStoU=A4W5OgOqf=Ja4-jC8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 February 2011 16:46, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 15, 2011 at 04:11:09PM +0100, Per Forlin wrote:
>> True. In my case write back is disable but read back is enable, that's
>> why I didn't consider it.
>
> What do you mean "write back is disable" ? ?You can only prevent
> writebacks by using a write-through cache.
>
I meant "no write allocate"

> Any writeback cache, whether in read-allocate or read-write-allocate
> mode will have writebacks.
>
Yepp, this is where I jumped to conclusions. I thought there would be
no writebacks if using "no write allocate". Now that I look at the
cache documentation again it feels so obvious.

Thanks for explaining this to me,
Per
