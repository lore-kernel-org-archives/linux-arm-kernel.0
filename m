From: khilman@ti.com (Kevin Hilman)
Date: Mon, 19 Mar 2012 14:39:12 -0700
Subject: [PATCH] ARM: OMAP2+: gpmc-smsc911x: only register regulator for
 first instance
In-Reply-To: <201203192118.09286.arnd@arndb.de> (Arnd Bergmann's message of
 "Mon, 19 Mar 2012 21:18:09 +0000")
References: <1331080771-30687-1-git-send-email-khilman@ti.com>
 <201203192118.09286.arnd@arndb.de>
Message-ID: <87mx7c5kzj.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 07 March 2012, Kevin Hilman wrote:
>> commit e4b0b2cbbb (ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
>> regulators) added regulators which are registered during
>> gpmc_smsc911x_init().  However, some platforms (OMAP3/Overo) have more
>> than one instance of the SMSC911x and result in attempting to register
>> the same regulator more than once which causes a panic().
>> 
>> Fix this by only registering the regulator when the platform_data id
>> field is zero, indicating its the first instance.
>> 
>> Cc: Matt Porter <mporter@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> It seems that both Olof and I forgot to forward this one to Linus.
>
> If it's ok for you, I'll add it to the fixes branch for v3.4 now
> and mark it for backporting to v3.3-stable.

A slightly different version of this is already in linux-next as commit
bb60424af517d6e6148505fb5ef256caa91b5b43.

It was in your 'fixes' branch, and was merged by Olaf from Tony on 3/13:
Merge branch 'fix-smsc911x-regulator' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into fixes

Kevin
