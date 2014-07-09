From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 9 Jul 2014 10:46:03 -0700
Subject: [PATCH v3 4/9] of: mtd: add documentation for the ONFI NAND
 timing mode property
In-Reply-To: <537BC9D4.6070200@free-electrons.com>
References: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
 <1394647664-8258-5-git-send-email-b.brezillon.dev@gmail.com>
 <20140520182542.GS28907@ld-irv-0074>
 <537BAD59.3060902@free-electrons.com>
 <20140520195240.GW28907@ld-irv-0074>
 <537BC9D4.6070200@free-electrons.com>
Message-ID: <20140709174603.GJ7537@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

Looking back at this thread, there's at least one or two things I forgot
to answer. Sorry.

On Tue, May 20, 2014 at 11:32:04PM +0200, Boris BREZILLON wrote:
> On 20/05/2014 21:52, Brian Norris wrote:
[...]
> If the ECC bindings don't encode the "minimum required ECC strength" but
> rather the "ECC config on a specific board" then I guess "minimum
> required ECC strength" for non-ONFI chips should be defined somewhere
> else (stored in the device ID table ?).

They are. See nand_flash_dev::ecc, which holds fields for
ecc_strength_ds and step_ds. If we have to, we can add a "timing mode"
field to this struct.

> > So you're saying that even though the chip actually specifies a single
> > set of timings, you would describe this as a bitmask of several
> > supported ONFI timing modes, up to the "max performance"?
> >
> > Is there ever a case where (for instance) a non-ONFI flash supports the
> > equivalent of timing mode 3, but it does not support mode 2 or 1?
> 
> I don't think so.

OK, then I don't think the mask approach is necessary, if we do ever
settle on using a DT binding here. (I hope we can avoid this.)

> >> But I can modify the bindings to just encode the maximum supported
> >> timing mode.
> > AIUI, the non-ONFI datasheets really only specify a single timing mode,
> > so I think we should only specify the "max." And as a bonus, this
> > actually makes the binding easier to use. A driver does not care about
> > how many different modes are supported; it only needs to know what the
> > max is.
> 
> Agreed, actually my first binding was defining it this way.

Was there a good reason for changing it?

Thanks,
Brian
