From: imp@bsdimp.com (Warner Losh)
Date: Wed, 12 Mar 2014 14:18:27 -0600
Subject: [RFC PATCH v2 04/14] mtd: nand: define struct nand_timings
In-Reply-To: <20140312190737.GA27388@obsidianresearch.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
 <1391006064-28890-5-git-send-email-b.brezillon.dev@gmail.com>
 <531DC1A4.7010208@gmail.com> <20140311185554.GD31835@obsidianresearch.com>
 <53208F7D.8090104@gmail.com> <20140312190737.GA27388@obsidianresearch.com>
Message-ID: <5B3F0425-9D7A-4D22-86A0-2E870E25396A@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 12, 2014, at 1:07 PM, Jason Gunthorpe <jgunthorpe@obsidianresearch.com> wrote:

> On Wed, Mar 12, 2014 at 05:46:53PM +0100, Boris BREZILLON wrote:
>> I'm not a big fan of this name. I think timing structs should not
>> contain onfi in their names, because these timings are also
>> available on non ONFI chips.
> 
> Explicitly defering to the ONFI spec makes it clear what the
> definition of the timing parameter actually is.

This is good, since ONFI is a very public spec.

> If JEDEC has a different model then drivers will need to configure
> their interfaces a little differently.

JEDEC?s spec is just a public as ONFI?s, but in the past at least it has been difficult
to get without purchase.

> So we might end up with a jedec_sdr_timings too :|

And onfi_ddr_timings and jedec_ddr_timings since those timing modes are appearing
on shipping parts.

Warner
