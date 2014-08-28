From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 28 Aug 2014 11:21:02 +0100
Subject: [PATCH 5/6] arm64: Port SWP/SWPB emulation support from arm
In-Reply-To: <201408272030.07434.arnd@arndb.de> (Arnd Bergmann's message of
 "Wed, 27 Aug 2014 20:30:07 +0200")
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <20140826135623.GR23445@arm.com> <9hh4mwxesz8.fsf@arm.com>
 <201408272030.07434.arnd@arndb.de>
Message-ID: <9hhvbpcdiep.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 27 August 2014, Punit Agrawal wrote:
>> I'll replace the counters with trace points.
>> 
>> There is still the pr_warn which informs the user about applications
>> using legacy instructions. Hopefully, this should encourage updating the
>> software.
>
> pr_warn_ratelimit() please. There is no point printing this all the time
> if nobody reads the messages.

Agreed. The patch indeed uses pr_warn_ratelimit().

>
>> >> If we do both, there is no longer a need to have any debugfs file logic,
>> >> which is also a plus.
>> >
>> > Sounds good to me.
>> 
>> Just a note: instead of being 'swp_emulate.enable=0' this'll be
>> 'v7_obsolete.swp_emulate=0' and correspondingly for the other features.
>
> It would be nice if the module name could be the same for arm32 and arm64,
> and I don't know if we want to rename swp_emulate.c to v7_obsolete.c
> on arm32.

Catalin was suggesting renaming v7_obsolete.c, so I'll wait to see what
is the outcome there. Calling it swp_emulate.c feels wrong as in the
subsequent patch we add CP15 barrier emulation to it.

>
> Other than that, I have no opinion on the specific name of the module
> or the option.
>
> 	Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
