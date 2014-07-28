From: bp@alien8.de (Borislav Petkov)
Date: Mon, 28 Jul 2014 20:01:36 +0200
Subject: [RFC PATCH v3] edac: synps: Added EDAC support for zynq ddr ecc
 controller
In-Reply-To: <CAGnW=BaEn7mjW3fmCcuyqgsgG=L_j_1zwK9kXAsx9GsBbOXXfA@mail.gmail.com>
References: <64d65965-45a3-41c3-9b04-9743b8b1e49c@BL2FFO11FD025.protection.gbl>
 <20140728113446.GA5350@pd.tnic>
 <CAGnW=BaEn7mjW3fmCcuyqgsgG=L_j_1zwK9kXAsx9GsBbOXXfA@mail.gmail.com>
Message-ID: <20140728180136.GB7100@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 10:53:26PM +0530, punnaiah choudary kalluri wrote:
> I can agree with you that we can use shorter names.But ZYNQ has
> programmable logic next to processing system where one can add soft
> memory controller in the same system and may use different driver. So,
> the edac driver for zynq may include multiple drivers for different
> memory controllers in the same file. In this case it is difficult to
> maintain generic macros as you suggested above.

So?

You can still shorten them a bit - the current names are awfully long.
SYNPS_DDRC_ECC_ is too much information, for example. We know it is DDR
and we know it is about ECC. So do SYNPS and ZYNQ or OTHER or whatever
you wanna call it prefix and then the rest. I.e.,

    SYNPS_<reg>_<bits*>
    ZYNQ_<reg>_bits*>

You can even use single letter prefixes like S_ and Z_ and add a comment
explaining what those mean. Still much more readable than the long
repeating prefixes currently.

> Also the current edac framework for edac memory controllers is
> expecting the mc_num from the driver while allocating the memory
> controller instance using the edac_mc_alloc function. This requirement
> mandates that if the system contains two different memory controllers
> then the corresponding edac drivers should be in single file.

So you're telling me that you want one edac driver for *two* memory
controllers which can be present on a single system *at* *the* *same*
*time*? Is that it?

How exactly is that topology supposed to look like, work, etc, etc? What
kind of error reporting do you imagine you want to do with EDAC?

IOW, more info would be appreciated.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
