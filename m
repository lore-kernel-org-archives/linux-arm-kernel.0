From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 08 Mar 2012 18:44:39 -0700
Subject: [PULL] of nand generic binding
In-Reply-To: <4F576602.8020808@gmail.com>
References: <20120217155707.GR1214@game.jcrosoft.org>
 <20120229152534.GH3318@game.jcrosoft.org>
 <20120307082945.GJ21255@game.jcrosoft.org> <4F576602.8020808@gmail.com>
Message-ID: <20120309014439.235C23E0901@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 07 Mar 2012 07:43:30 -0600, Rob Herring <robherring2@gmail.com> wrote:
> On 03/07/2012 02:29 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 16:25 Wed 29 Feb     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> On 16:57 Fri 17 Feb     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>> HI,
> >>>
> >>> 	please find attached the generic binding for the MTD nand
> >>>
> >>> 	This will add boolean and nand helpers
> >> is it ok?
> > I need this for 3.4
> > 
> > will you apply it or can I apply it via AT91
> 
> Looks fine to me and Grant acked it, so go ahead and take with your at91
> branch.

Actually, taking another look at the of_mtd patch, that stuff really
belongs in the drivers/mtd directory.  I'm not nacking the patch, but
you should send a follow up to move it into the correct place.

I don't like the of_property_read_bool patch.  I don't want the
of_property_read_ functions to mix data return and error codes.
Either return a bool with an error code in the parameter list, or the
other way around.  Otherwise we'll end up with the same problem as
APIs that use the ERR_PTR() pattern where callers will use it without
understanding that the return value isn't necessarily a bool.

g.

> 
> Rob
> 
> > 
> > Best Regards,
> > J.
> > _______________________________________________
> > devicetree-discuss mailing list
> > devicetree-discuss at lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/devicetree-discuss
> 

-- 
email sent from notmuch.vim plugin
