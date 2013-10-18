From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Fri, 18 Oct 2013 12:35:57 -0400
Subject: [RFC 0/1] Device Tree Schema Source format proposal
In-Reply-To: <526158F3.4060104@baylibre.com>
References: <9610740.2oBMxfeRkE@amdc1227>
	<526158F3.4060104@baylibre.com>
Message-ID: <CAKON4OzqFtp8YKNvAxBnEwjTL1NS28OZW3AoVdCmu=+q9XWXog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Long ago when I first started talking about schemas the main thing I
had envisioned was a single schema for all of Linux.  You should be
able to take every dts file in the kernel and validate it against this
single schema.  This global schema would become the mechanism to
control how the various dts files evolve.

In this vision there would be a schema file for uarts. And another one
for spi. Another one for gpio, etc. These file would document all
possible attributes for these nodes. Lot of comments in these files
relative to the schema content.  The subsystem maintainers would
control this file which would then enable them to control the
proliferation of attributes.  No more things like num-cs, spi-num-cs,
cselects, ncs - all meaning the same thing, number of chip selects.
Higher level schema files would then describe how these subsystem
schemas can be combined.

As a side effect these files now make it much easier to define the
device tree syntax for new hardware. There is a single file to read to
find out the attributes is use for this class of subsystem device.  So
any new DTS would have to validate against this global scheme before
being accepted.  If you need new attributes you will have to talk to
subsystem maintainer into adding them to the schema file before your
code will be accepted.

So in general this scheme is a fair loose specification primarily
aimed at helping people reuse existing attributes instead of creating
new ones.  These subsystem schemas will be closely aligned with helper
libraries provided by the subsystem.  The more commonality we find,
the more code that can be refactored into helper libraries.

Also, having this loose schema framework doesn't preclude having more
than one schema. For example TI might want to provide a much tighter
schema that is only useful for validating Omap device trees.

One way to look at this is to envision two types of schemas. The
global Linux schema is a horizontal schema whose goal is to achieve as
much cross platform compatibility as possible. The TI Omap schema is a
vertical schema whose goal is to do as much error checking as
possible. Both of these schemas can be developed using the same schema
processor.

-- 
Jon Smirl
jonsmirl at gmail.com
