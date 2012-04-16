From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Apr 2012 15:02:32 +0000
Subject: [PATCH v6 17/17] pwm: Take over maintainership of the PWM
 subsystem
In-Reply-To: <20120416055012.GA3037@avionic-0098.adnet.avionic-design.de>
References: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
 <20120412122740.GB5353@avionic-0098.adnet.avionic-design.de>
 <20120416055012.GA3037@avionic-0098.adnet.avionic-design.de>
Message-ID: <201204161502.32620.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 April 2012, Thierry Reding wrote:
> Seems like this issue is resolved, but something else came up. In the !OF
> builds, of_pwm_request() no longer builds because of_property_match_string()
> and of_parse_phandle_with_args() have no dummies for !OF. I've posted patches
> for these on Friday and they need to go in before the PWM subsystem. I could
> also revert the IS_ENABLED() parts and go back to a #ifdef CONFIG_OF but I'd
> rather not.
> 

Agreed, using IS_ENABLED from C code is much nicer than #ifdef because
we can be sure that all code actually builds.

	Arnd
