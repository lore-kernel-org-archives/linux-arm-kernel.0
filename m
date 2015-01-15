From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Jan 2015 17:52:31 +0100
Subject: [Linaro-acpi] [PATCH v5 18/18] Documentation: ACPI for ARM64
In-Reply-To: <54B7E21E.2000901@redhat.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <CACxGe6tjiE6u8i-1PHYzX2cOhxJkYN3cV9mqhCHRSMRdOQRfzg@mail.gmail.com>
 <54B7E21E.2000901@redhat.com>
Message-ID: <2277974.2klgILPa2Q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 January 2015 10:51:58 Jon Masters wrote:
> On 01/15/2015 09:10 AM, Grant Likely wrote:
> > On Tue, Jan 6, 2015 at 1:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> For drivers merged upstream, I would insist that every driver merged
> >> for an ARM64 platform has a documented DT binding that is used in the
> >> driver.
> > 
> > That's a dumb rule. It will result in untested DT code paths being
> > thrown into drivers just too meet the rules rather than on whether or
> > not they will actually be used. It's fine to allow driver authors to
> > only implement the ACPI code path if that is what they are working
> > with. We can *always* add a DT path to the driver when it is needed.
> 
> It gets worse. There *will* be large numbers of ACPI only ARM servers
> landing over the coming year. Not only would DT code be untested, but
> insisting on keeping e.g. a DSDT and DT in sync is never going to work
> anyway. Already we have early stage servers that contain a DT used for
> bringup that is subsequently not being updated as often as the ACPI
> tables (those systems are now booting exclusively in labs with ACPI).
> Eventually, I am going to push for the DT data to be removed from these
> systems rather than have out of date unmaintained DT data in firmware.

We will of course be able to relax the rule once ACPI has stabilized on
ARM64. At the moment, we haven't even agreed on how to represent basic
devices, so things are in flux and there is no way for a BIOS writer
to ship an image that we will guarantee to support in the long run.

At some point after we are reasonably sure we are able to keep supporting
all existing systems that are working with that kernel, we can take
support for new systems without having DT by default, and also support
booting those without acpi=force, which is related to this question.

	Arnd
