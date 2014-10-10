From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 9 Oct 2014 21:55:24 -0700
Subject: [PATCH v2 5/5] m25p80,spi-nor: Share the list of supported chip
 type names again
In-Reply-To: <1412076963.9388.96.camel@decadent.org.uk>
References: <1412043222.9388.81.camel@decadent.org.uk>
 <1412043352.9388.86.camel@decadent.org.uk>
 <CACna6ry3=+1GLRCvd_xOGBHjQmEGdYT-eM4YFfzO2Fkw9BHSTA@mail.gmail.com>
 <1412076963.9388.96.camel@decadent.org.uk>
Message-ID: <20141010045524.GD22169@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 12:36:03PM +0100, Ben Hutchings wrote:
> On Tue, 2014-09-30 at 10:02 +0200, Rafa? Mi?ecki wrote:
> > On 30 September 2014 04:15, Ben Hutchings <ben@decadent.org.uk> wrote:
> > > Move the list of chip type information to a macro in spi-nor.h, but
> > > leave the definitions of INFO and CAT25_INFO in spi-nor.
> > >
> > > In m25p80, define the INFO and CAT25_INFO macros to initialise a
> > > struct spi_device_id with the name, ignoring the remaining parameters.
> > 
> > Anyone would consider my idea proposed in 1/5 thread?
> > 
> > We could simply follow the way Linux-specific platform data works. We
> > could always use
> > compatible = "m25p80";
> > and then for some rare cases (where JEDEC fails) add something like
> > model = "at25df321a";
> > 
> > Using above way we could use a one single "compatible" in m25p80.c and
> > avoid this messy share of id_table.
> 
> You *cannot* define a DT compatible string by reference to out-of-band
> information about all the chips that has to be updated for each new
> chip.
> 
> That is not 'compatible'.

Well, for the DT case at least, what is the problem with including two
(or more) compatible strings in the board DT, but the driver only
binding against the common one ("m25p80" or something like
"spi-nor,jedec-id") unless necessary? You can still follow best DT
practices formally without always binding to the most specific string
when that doesn't buy you anything.

The true board file / platform data cases are slightly different, but in
those cases, the board file can evolve in sync with drivers, I think.

Brian
