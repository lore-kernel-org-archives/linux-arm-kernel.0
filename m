From: mans.rullgard@linaro.org (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 15 Nov 2012 15:14:42 +0000
Subject: [PATCH] ARM: Fix errata 751472 handling on Cortex-A9 r1p*
In-Reply-To: <20121115135246.GB25985@arm.com> (Catalin Marinas's message of
 "Thu, 15 Nov 2012 13:52:46 +0000")
References: <20121114185335.GU6801@atomide.com> <50A3EBCD.3040801@ti.com>
 <20121114202244.GE3332@n2100.arm.linux.org.uk>
 <20121114203221.GA6801@atomide.com> <50A413D4.7000405@gmail.com>
 <20121114222159.GB6801@atomide.com> <50A43D58.5030404@gmail.com>
 <20121115110137.GA25985@arm.com>
 <CACY+gR3PurUofCbUeG40B6vXqXAoHrMmbOQSuwAGoc1LS8XXJQ@mail.gmail.com>
 <20121115135246.GB25985@arm.com>
Message-ID: <yw1x1ufux5i5.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Nov 15, 2012 at 12:41:43PM +0000, Siarhei Siamashka wrote:
>> BTW, I always wondered about what could be preventing TI and the other
>> silicon vendors from using something like an SMC API based on
>> asymmetric cryptography? My understanding is that for OMAP4 GP chips,
>> ROM code switches to non-secure mode before passing control to the
>> bootloader and there is simply no way to workaround bugs like this.
>
> AFAIK, there are some SMCs to the OMAP secure firmware that allow such
> bits to be set (see omap4_l2x0_set_debug() for example). I'm not sure
> they are documented.

The trouble with OMAP is that the secure ROM API only allows access to a
tiny subset of the registers we'd need.  In part this can be explained
by the important OMAP customers all using the HS chips with full access
to secure mode.

-- 
M?ns Rullg?rd
mans at mansr.com
