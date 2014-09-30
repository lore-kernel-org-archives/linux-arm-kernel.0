From: ben@decadent.org.uk (Ben Hutchings)
Date: Tue, 30 Sep 2014 12:36:03 +0100
Subject: [PATCH v2 5/5] m25p80,spi-nor: Share the list of supported chip
 type names again
In-Reply-To: <CACna6ry3=+1GLRCvd_xOGBHjQmEGdYT-eM4YFfzO2Fkw9BHSTA@mail.gmail.com>
References: <1412043222.9388.81.camel@decadent.org.uk>
 <1412043352.9388.86.camel@decadent.org.uk>
 <CACna6ry3=+1GLRCvd_xOGBHjQmEGdYT-eM4YFfzO2Fkw9BHSTA@mail.gmail.com>
Message-ID: <1412076963.9388.96.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-09-30 at 10:02 +0200, Rafa? Mi?ecki wrote:
> On 30 September 2014 04:15, Ben Hutchings <ben@decadent.org.uk> wrote:
> > Move the list of chip type information to a macro in spi-nor.h, but
> > leave the definitions of INFO and CAT25_INFO in spi-nor.
> >
> > In m25p80, define the INFO and CAT25_INFO macros to initialise a
> > struct spi_device_id with the name, ignoring the remaining parameters.
> 
> Anyone would consider my idea proposed in 1/5 thread?
> 
> We could simply follow the way Linux-specific platform data works. We
> could always use
> compatible = "m25p80";
> and then for some rare cases (where JEDEC fails) add something like
> model = "at25df321a";
> 
> Using above way we could use a one single "compatible" in m25p80.c and
> avoid this messy share of id_table.

You *cannot* define a DT compatible string by reference to out-of-band
information about all the chips that has to be updated for each new
chip.

That is not 'compatible'.

Ben.

-- 
Ben Hutchings
The two most common things in the universe are hydrogen and stupidity.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/63ecbf08/attachment.sig>
