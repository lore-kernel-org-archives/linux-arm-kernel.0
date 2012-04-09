From: cjb@laptop.org (Chris Ball)
Date: Mon, 09 Apr 2012 10:41:30 -0400
Subject: [PATCH 6/7] MMC: mmci: Enable Device Tree support for ux500
 variants
In-Reply-To: <201204091427.19110.arnd@arndb.de> (Arnd Bergmann's message of
 "Mon, 9 Apr 2012 14:27:18 +0000")
References: <1333619748-16126-1-git-send-email-lee.jones@linaro.org>
 <4F7DA1DE.2030203@linaro.org> <20120406041401.28A993E0BC4@localhost>
 <201204091427.19110.arnd@arndb.de>
Message-ID: <87wr5px90l.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 09 2012, Arnd Bergmann wrote:
> Agreed.
>
> Should we use max-frequency or clock-frequency for sdhci though? It looks
> like this is both the maximum frequency that it can use and the base frequency
> that the actual clock rate is derived from (can be a fraction).

This is ultimately setting the "f_max" ("maximum operating frequency")
field in the MMC core, so I'm happy naming the property "max-frequency".

It's true that this doesn't explain the derivation to clock rate --
but we weren't doing that before the DT binding either, and I think that
having a discrepancy between the DT property and the core's naming would
lead to confusion/mistakes.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
