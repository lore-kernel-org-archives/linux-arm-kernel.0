From: khilman@ti.com (Kevin Hilman)
Date: Tue, 08 May 2012 15:16:36 -0700
Subject: [linux-pm] [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage
 Scaling)
In-Reply-To: <EF62F09C0797D947AD4180A1043C0DF73C40BCE1@DLEE10.ent.ti.com>
 (Richard Woodruff's message of "Tue, 8 May 2012 20:38:35 +0000")
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
 <20120426191159.GA9415@sirena.org.uk>
 <CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
 <20120427175657.GP18260@opensource.wolfsonmicro.com>
 <87397o3n4y.fsf@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9B1A67@DBDE01.ent.ti.com>
 <87mx5jy2li.fsf@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13E9B6681@DBDE01.ent.ti.com>
 <EF62F09C0797D947AD4180A1043C0DF73C40BCE1@DLEE10.ent.ti.com>
Message-ID: <87lil2jp2z.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Woodruff, Richard" <r-woodruff2@ti.com> writes:

>> > >> The only thing the higher-level layers might potentially need to
>> > >> do is to enable/disable AVS around transitions (e.g. when
>> > >> changing OPP, > > >> AVS is disabled before changing OPP and
>> > >> only re-enabled when the new > >> >> nominal voltage has been
>> > >> acheived.)
>
> Getting clean baseline in place is huge step but actual production
> interfaces will need to comprehend some OPP to AVS dependencies beyond
> on/off.

A basic OMAP AVS driver has been in mainline for a long time, yet we
have not seen support submitted for all of these features.

When folks are motivated to propose such changes upstream, we will be
happy to discuss them and add support for them to the AVS driver.

Until then, the primary purpose of this series is to do some minimal
cleanup of an *existing* driver so it can be moved into drivers/*.  New
features can be added there as easily as they could've been added when
it was a driver under arch/arm.

Kevin
