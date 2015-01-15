From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Jan 2015 18:00:33 +0000
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <2277974.2klgILPa2Q@wuerfel>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6tjiE6u8i-1PHYzX2cOhxJkYN3cV9mqhCHRSMRdOQRfzg@mail.gmail.com>
 <54B7E21E.2000901@redhat.com> <2277974.2klgILPa2Q@wuerfel>
Message-ID: <20150115180033.GE3043@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 05:52:31PM +0100, Arnd Bergmann wrote:
> On Thursday 15 January 2015 10:51:58 Jon Masters wrote:

> > It gets worse. There *will* be large numbers of ACPI only ARM servers
> > landing over the coming year. Not only would DT code be untested, but
> > insisting on keeping e.g. a DSDT and DT in sync is never going to work
> > anyway. Already we have early stage servers that contain a DT used for
> > bringup that is subsequently not being updated as often as the ACPI
> > tables (those systems are now booting exclusively in labs with ACPI).
> > Eventually, I am going to push for the DT data to be removed from these
> > systems rather than have out of date unmaintained DT data in firmware.

> We will of course be able to relax the rule once ACPI has stabilized on
> ARM64. At the moment, we haven't even agreed on how to represent basic
> devices, so things are in flux and there is no way for a BIOS writer
> to ship an image that we will guarantee to support in the long run.

> At some point after we are reasonably sure we are able to keep supporting
> all existing systems that are working with that kernel, we can take
> support for new systems without having DT by default, and also support
> booting those without acpi=force, which is related to this question.

Speaking with my subsystem maintainer hat on (admittedly not subsystems
affected too much by ARM servers so take this with a pinch of salt) this
just sounds like it's making more work for me - it means having to force
people to write DT code and bindings which I'm then going to have to
review and none of us really care about.  Realistically I'm just going
to take the code if a lack of a DT binding is the only option, I suspect
others will be similar.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/bdc29ddd/attachment.sig>
