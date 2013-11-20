From: giometti@enneenne.com (Rodolfo Giometti)
Date: Wed, 20 Nov 2013 19:18:42 +0100
Subject: [RFC PATCH v2] ARM: at91: add support for Cosino board series by
 HCE Engineering
In-Reply-To: <20131115135256.GP28304@ns203013.ovh.net>
References: <1383754767-5398-1-git-send-email-giometti@linux.it>
 <1384364070-32306-1-git-send-email-nicolas.ferre@atmel.com>
 <20131114162810.GJ28304@ns203013.ovh.net>
 <20131114185002.GM10964@enneenne.com>
 <20131115135256.GP28304@ns203013.ovh.net>
Message-ID: <20131120181841.GQ4578@enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 02:52:56PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > +#include "at91sam9g35.dtsi"
> > > > +
> > > > +/ {
> > > > +	model = "HCE Cosino core module";
> > > > +	compatible = "hce,cosino", "atmel,at91sam9x5ek", "atmel,at91sam9x5", "atmel,at91sam9";
> > > is this really sam9xek compatible?
> > 
> > Well, the board is derived from ATMEL dev board... maybe I can remove
> > these lines... :-/
> 
> compatible means you board is an extension and that the kernel + dtb will run
> on both without modification

Ok, at91sam9x5ek dropped.

> > +
> > +			mmc1: mmc at f000c000 {
> > +				pinctrl-0 = <
> > +					&pinctrl_board_mmc0
> this will failled you can not have the same pux on 2 device

Fixed.

Attached a new patch version (V3).

### Changelog

V2 -> V3

[Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>]
* Reference to at91sam9x5ek dropped.
* Inavlid mmc1 pinctrl-0 setting fixed

V1 -> V2

[Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>]
* prefix "at91-" added
* atmel,mux-mask stuff removed
* "compatible" stuff is now on the same line for easy-grep(TM)
* lcd binding dropped

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti at enneenne.com
Linux Device Driver                          giometti at linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-arm-mach-at91-add-support-for-Cosino-board-series-by.patch
Type: text/x-diff
Size: 5913 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131120/c06f5cf8/attachment.bin>
