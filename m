From: ben@decadent.org.uk (Ben Hutchings)
Date: Tue, 30 Sep 2014 02:50:40 +0100
Subject: [PATCH 5/5] m25p80,spi-nor: Share the list of supported chip
 type names again
In-Reply-To: <CAMuHMdVSYvUh3qVRhw15KmOn0MYocbJVQBr9TkHtebM19c8dJA@mail.gmail.com>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714708.3040.43.camel@decadent.org.uk>
 <CAMuHMdUs+7uidcD6tivnq6+TbD4_piixLVqwuSa0Z1u3sF7EoA@mail.gmail.com>
 <1410793627.3040.61.camel@decadent.org.uk>
 <CAMuHMdVSYvUh3qVRhw15KmOn0MYocbJVQBr9TkHtebM19c8dJA@mail.gmail.com>
Message-ID: <1412041840.9388.77.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-09-17 at 10:23 +0200, Geert Uytterhoeven wrote:
> Hi Ben,
> 
> On Mon, Sep 15, 2014 at 5:07 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
> >> >
> >> > +#define __SPI_NOR_ENUM_TYPES(c_id, str_and_c_id)                         \
> >> > +       c_id(at25fs010)         c_id(at25fs040)         c_id(at25df041a)  \
> >> > +       c_id(at25df321a)        c_id(at25df641)         c_id(at26f004)    \
> >>
> >> Can't you just have the IDs in a header file only, and let the header file
> >> generate either a struct flash_info or a struct spi_device_id table, using
> >> a macro defined by the file that includes it?
> >
> > How would we match up the rest of the struct flash_info to the name?
> 
> Ah, you use the enums to match the names to the rest of the flash_info.
> But you can do it in one-shot, can't you?
[...]

I know, but I didn't want to expose the data in a header file.  As other
people consider that a lesser evil than this rather complex approach,
I'll do it the simple way.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/2e442ad3/attachment.sig>
