From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Oct 2015 15:15:52 +0100
Subject: [PATCHv2] arm: perf: Add event descriptions
In-Reply-To: <20151012181037.GA16013@dreric01-gentoo.localdomain>
References: <20151007182735.GA18706@dreric01-gentoo.localdomain>
 <20151009101338.GH26278@arm.com>
 <20151009165330.GA22415@dreric01-gentoo.localdomain>
 <20151012143025.GG16124@arm.com>
 <20151012181037.GA16013@dreric01-gentoo.localdomain>
Message-ID: <20151013141551.GK21550@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 11:10:38AM -0700, Drew Richardson wrote:
> On Mon, Oct 12, 2015 at 03:30:25PM +0100, Will Deacon wrote:
> > I think this looks much better, thanks. The only thing left to do is
> > re-use some of the existing event descriptions from the enum
> > armv7_perf_types that we have at the top of the file, rather than
> > duplicate the event -> ID mapping. Feel free to extend the enumeration
> > if you need to (it's intended to cover all of the architected events).
> 
> OK, here you go. I agree that duplicating the event -> ID mapping is
> undesirable, but some rather ugly preprocessor stuff is required to
> convert the enum into it's hex value (is there a better way to do
> this?). I think it may be less ugly if we build the string at runtime
> instead of at compile time (ie, going back to using PMU_EVENT_ATTR
> instead of PMU_EVENT_ATTR_STRING).

Yeah, I see what you mean. However, I don't think we actually need these
as an enum, do we? So maybe just replace the whole lot with a bunch of
#defines (mechanical change since they're already namespaced, separate
patch before this one) and then have this patch use those #defines for
the sysfs stuff.

Sorry for the to-and-fro-ing on this.

Will
