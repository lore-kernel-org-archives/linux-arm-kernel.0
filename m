From: broonie@kernel.org (Mark Brown)
Date: Mon, 11 Aug 2014 13:24:15 +0100
Subject: [alsa-devel] [PATCH] ASoC: rt286: Add API to set supported jack
 type
In-Reply-To: <1407751185.2487.150.camel@loki>
References: <1407217970-20126-1-git-send-email-bardliao@realtek.com>
 <20140806205421.GZ17528@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7608E00@RTITMBSV03.realtek.com.tw>
 <20140807173136.GN17528@sirena.org.uk>
 <1407751185.2487.150.camel@loki>
Message-ID: <20140811122415.GZ17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 10:59:45AM +0100, Liam Girdwood wrote:
> On Thu, 2014-08-07 at 18:31 +0100, Mark Brown wrote:

> > I've CCed in Graeme Gregory who's been writing some guidelines for this
> > sort of thing in the context of ARMv8 serviers - the most recent patch
> > is:

> >    http://thread.gmane.org/gmane.linux.acpi.devel/69757

> > The advice there looks good to me - see the "Device Enumeration"
> > section.

> This is indeed good, just too late for the initial Broadwell BIOSes that
> wont have this _DSD field for the codec (it will be hard coded for
> Windows anyway).

Sounds like DMI is going to be needed then - whatever ends up being done
I'd expect it should just be a case of putting the checks done to work
out the machine configuration into the CODEC driver instead of the
machine driver.  If it looks ugly this can be used to explain to people
why we need something more sensible!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140811/735ec64f/attachment.sig>
