From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 22 Nov 2012 06:33:13 +0100
Subject: [PATCH 1/4] OF: Add helper for matching against linux, stdout-path
In-Reply-To: <20121121172631.GV10369@pengutronix.de>
References: <20121121155312.GX4398@game.jcrosoft.org>
 <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
 <20121121172631.GV10369@pengutronix.de>
Message-ID: <20653.47385.793796.215803@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer writes:
> On Wed, Nov 21, 2012 at 04:57:05PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > devicetrees may have a linux,stdout-path or stdout-path property
> > in the chosen node describing the console device. This adds a helper
> > function to match a device against this property and retrieve the options
> > so a driver can call add_preferred_console for a matching device.
> > 
[...]
> > +	if (!tmp)
> > +		return 0;
> > +
> > +	dn_stdout = of_find_node_by_path(tmp);
> > +
> > +	if (dn_stdout && dn_stdout == dn) {
> > +		is_stdout = 1;
> > +		tmp_option++;
> > +		*option = kstrdup(tmp_option, GFP_KERNEL);
> > +	}
> > +
> > +	of_node_put(dn_stdout);
> 
> dn_stdout may be NULL aswell.
> 
which is handled gracefully by of_node_put()...


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
