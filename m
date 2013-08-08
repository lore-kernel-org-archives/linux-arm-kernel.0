From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 08 Aug 2013 11:16:44 -0700
Subject: [PATCHv3 4/9] ARM: OMAP2+: AM33XX: Reserve memory to comply with
 EMIF spec
In-Reply-To: <1375811376-49985-5-git-send-email-d-gerlach@ti.com> (Dave
 Gerlach's message of "Tue, 6 Aug 2013 12:49:31 -0500")
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-5-git-send-email-d-gerlach@ti.com>
Message-ID: <87fvukhwtv.fsf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Gerlach <d-gerlach@ti.com> writes:

> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>
> SDRAM controller on AM33XX requires that a modification of certain
> bit-fields in PWR_MGMT_CTRL register (ref. section 7.3.5.13 in
> AM335x-Rev H) is followed by a dummy read access to SDRAM. This
> scenario arises when entering a low power state like DeepSleep.
> To ensure that the read is not from a cached region we reserve
> some memory during bootup using the arm_memblock_steal() API.

Hmm, sounds to me an awful lot like the existing omap_bus_sync() ?

However, you remove that feature when you remove omap_reserve() here
becasue omap_reserve() ss not called from your new reserve function.
Are you *really* sure you don't need the functions called there?  This
is a pretty big change that's not mentioned anywhere in the changelog.

Kevin
