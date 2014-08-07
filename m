From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 Aug 2014 18:31:36 +0100
Subject: [PATCH] ASoC: rt286: Add API to set supported jack type
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7608E00@RTITMBSV03.realtek.com.tw>
References: <1407217970-20126-1-git-send-email-bardliao@realtek.com>
 <20140806205421.GZ17528@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7608E00@RTITMBSV03.realtek.com.tw>
Message-ID: <20140807173136.GN17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 07, 2014 at 01:43:24AM +0000, Bard Liao wrote:

> > If this is coming from the hardware design I'd expect this to be configured
> > via platform data or firmware data rather than with an API.
> > Why do it this way?

> Actually, this patch is for Intel platform which doesn't support platform data
> yet. That's why we create an API so they can call the API in machine driver.

So, this is something that the people wanting to use ACPI in platforms
with devices like this are going to have to deal with - we need a way of
getting configuration to devices.  Traditionally small tweaks have been
done based on DMI information but that's not at all scalable.  I believe
newer ACPI specs are trying to accomodate this due to the expanding
range of systems supporting ACPI.  Punting to the machine driver just
moves the problem around, it doesn't really address it.

I've CCed in Graeme Gregory who's been writing some guidelines for this
sort of thing in the context of ARMv8 serviers - the most recent patch
is:

   http://thread.gmane.org/gmane.linux.acpi.devel/69757

The advice there looks good to me - see the "Device Enumeration"
section.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140807/f6928c49/attachment.sig>
