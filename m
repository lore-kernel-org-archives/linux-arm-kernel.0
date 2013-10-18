From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Fri, 18 Oct 2013 12:49:40 -0400
Subject: [RFC 0/1] Device Tree Schema Source format proposal
In-Reply-To: <CAKON4OzqFtp8YKNvAxBnEwjTL1NS28OZW3AoVdCmu=+q9XWXog@mail.gmail.com>
References: <9610740.2oBMxfeRkE@amdc1227> <526158F3.4060104@baylibre.com>
 <CAKON4OzqFtp8YKNvAxBnEwjTL1NS28OZW3AoVdCmu=+q9XWXog@mail.gmail.com>
Message-ID: <CAKON4OzxWNRNi+nb-2u+B7V1F2nh=3QGV2XpppMtYEPHY-haLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 12:35 PM, jonsmirl at gmail.com <jonsmirl@gmail.com> wrote:
> Long ago when I first started talking about schemas the main thing I
> had envisioned was a single schema for all of Linux.  You should be
> able to take every dts file in the kernel and validate it against this
> single schema.  This global schema would become the mechanism to
> control how the various dts files evolve.
>
> In this vision there would be a schema file for uarts. And another one
> for spi. Another one for gpio, etc. These file would document all
> possible attributes for these nodes. Lot of comments in these files
> relative to the schema content.  The subsystem maintainers would
> control this file which would then enable them to control the
> proliferation of attributes.  No more things like num-cs, spi-num-cs,
> cselects, ncs - all meaning the same thing, number of chip selects.
> Higher level schema files would then describe how these subsystem
> schemas can be combined.
>
> As a side effect these files now make it much easier to define the
> device tree syntax for new hardware. There is a single file to read to
> find out the attributes is use for this class of subsystem device.  So
> any new DTS would have to validate against this global scheme before
> being accepted.  If you need new attributes you will have to talk to
> subsystem maintainer into adding them to the schema file before your
> code will be accepted.

The subsystem schema files would contain all possible agreed to
attributes even if some of those attributes were vendor specific.  So
there might be an entry for amd,fancy-attribute and then intel comes
along an implements a similar feature.  When Intel submitted their
intel,fancy-attribute the subsystem the maintainer would then
intervene and create a generic fancy-attribute.

This implies that schema should allow for attributes marked legacy. In
this case amd,fancy-attribute would be marked legacy when the generic
form was created.

Legacy attributes should produce warnings during validation.


>
> So in general this scheme is a fair loose specification primarily
> aimed at helping people reuse existing attributes instead of creating
> new ones.  These subsystem schemas will be closely aligned with helper
> libraries provided by the subsystem.  The more commonality we find,
> the more code that can be refactored into helper libraries.
>
> Also, having this loose schema framework doesn't preclude having more
> than one schema. For example TI might want to provide a much tighter
> schema that is only useful for validating Omap device trees.
>
> One way to look at this is to envision two types of schemas. The
> global Linux schema is a horizontal schema whose goal is to achieve as
> much cross platform compatibility as possible. The TI Omap schema is a
> vertical schema whose goal is to do as much error checking as
> possible. Both of these schemas can be developed using the same schema
> processor.
>
> --
> Jon Smirl
> jonsmirl at gmail.com



-- 
Jon Smirl
jonsmirl at gmail.com
