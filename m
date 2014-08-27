From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Aug 2014 20:30:07 +0200
Subject: [PATCH 5/6] arm64: Port SWP/SWPB emulation support from arm
In-Reply-To: <9hh4mwxesz8.fsf@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <20140826135623.GR23445@arm.com> <9hh4mwxesz8.fsf@arm.com>
Message-ID: <201408272030.07434.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 August 2014, Punit Agrawal wrote:
> I'll replace the counters with trace points.
> 
> There is still the pr_warn which informs the user about applications
> using legacy instructions. Hopefully, this should encourage updating the
> software.

pr_warn_ratelimit() please. There is no point printing this all the time
if nobody reads the messages.

> >> If we do both, there is no longer a need to have any debugfs file logic,
> >> which is also a plus.
> >
> > Sounds good to me.
> 
> Just a note: instead of being 'swp_emulate.enable=0' this'll be
> 'v7_obsolete.swp_emulate=0' and correspondingly for the other features.

It would be nice if the module name could be the same for arm32 and arm64,
and I don't know if we want to rename swp_emulate.c to v7_obsolete.c
on arm32.

Other than that, I have no opinion on the specific name of the module
or the option.

	Arnd
