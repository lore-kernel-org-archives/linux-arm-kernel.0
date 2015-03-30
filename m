From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 30 Mar 2015 20:32:34 +0200
Subject: [PATCH 1/6] clk: make strings in parent name arrays const
In-Reply-To: <1427739631.14276.23.camel@perches.com>
References: <1427739631.14276.23.camel@perches.com>
Message-ID: <20150330183234.GH9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 11:20:31AM -0700, Joe Perches wrote:
> On Mon, 2015-03-30 at 20:16 +0200, Sascha Hauer wrote:
> > On Mon, Mar 30, 2015 at 10:55:19AM -0700, Joe Perches wrote:
> > > On Mon, 2015-03-30 at 19:40 +0200, Sascha Hauer wrote:
> > > > The clk functions and structs declare the parent_name arrays as
> > > > 'const char **parent_names' which means the parent name strings
> > > > are const, but the array itself is not. Use
> > > > 'const char * const * parent_names' instead which also makes
> > > > the array const. This allows us to put the parent_name arrays into
> > > > the __initconst section.
> > > 
> > > If these are pointer entries are stored, care needs to be
> > > taken to make sure that the memory isn't discarded or needed
> > > post init.
> > 
> > The clock framework makes deep copies of all initialization data
> > structures.
> 
> Great.  Is/Should that be documented somewhere?

I have no idea if/where this is documented.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
