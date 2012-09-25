From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Tue, 25 Sep 2012 10:46:34 +0200
Subject: [PATCH v2] arm: make FORCE_MAX_ZONEORDER configurable for TI
 AM33XX
In-Reply-To: <20120925083245.GH31374@n2100.arm.linux.org.uk>
References: <1348561590-13361-1-git-send-email-yegorslists@googlemail.com>
 <20120925083245.GH31374@n2100.arm.linux.org.uk>
Message-ID: <50616F6A.80100@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.09.2012 10:32, Russell King - ARM Linux wrote:
> On Tue, Sep 25, 2012 at 10:26:30AM +0200, yegorslists at googlemail.com wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> FORCE_MAX_ZONEORDER of 12 is needed to allocation more than 4MB
>> of consistent DMA memory (da8xx frame buffer driver).
> 
> Okay, so the patch description says "This needs to be 12 on this platform".
> 
>>  config FORCE_MAX_ZONEORDER
>> -	int "Maximum zone order" if ARCH_SHMOBILE
>> -	range 11 64 if ARCH_SHMOBILE
>> +	int "Maximum zone order" if ARCH_SHMOBILE || SOC_AM33XX
>> +	range 11 64 if ARCH_SHMOBILE || SOC_AM33XX
> 
> but you leave it up to the user to select something that may not be
> suitable.  Wouldn't _just_ adding:
> 
> 	default "12" if SOC_AM33XX
> 
> after the "range", and making no other changes be good enough and match
> what the patch description says?

You're right. As we don't allocate anything, but increase the possible size, it shouldn't break anything. Tony is it O.K. with you?

Patch sent.

Yegor
