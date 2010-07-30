From: rabin@rab.in (Rabin Vincent)
Date: Sat, 31 Jul 2010 05:14:09 +0530
Subject: [PATCH] fix Thumb-2 decompressor broken by "Auto calculate
	ZRELADDR"
In-Reply-To: <20100730205756.GA28316@pengutronix.de>
References: <1280518523-5526-1-git-send-email-rabin@rab.in>
	<20100730205756.GA28316@pengutronix.de>
Message-ID: <AANLkTi=GkKnnLNA_Mf085KgTz+uNHxnZsSe_3mB1xyWv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/31 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> On Sat, Jul 31, 2010 at 01:05:23AM +0530, Rabin Vincent wrote:
>> Fix it, and also change the ARM code to use the separate SP-load since
>> ARM instructions that include the SP in the LDM register list are
>> deprecated.
> I only found:
>
> ? ? ? ?LDM{<cond>}<addressing_mode> <Rn>{!}, <registers>
> ? ? ? ?...
> ? ? ? ?If the base register <Rn> is specified in <registers>, and base
> ? ? ? ?register write-back is specified,
> ? ? ? ?the final value of <Rn> is UNPREDICTABLE.
>
> Are you really sure about this? ?Where do you know it from?

This is in section "A8.6.53 LDM / LDMIA / LDMFD" of the
ARM ARM (v7 edition):

  LDM<c><q> <Rn>{!}, <registers>

  <registers> The SP can be in the list in ARM code, but not
  in Thumb code. However, ARM instructions that include the
  SP in the list are deprecated.
