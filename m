From: jon@solid-run.com (Jon Nettleton)
Date: Sun, 9 Jul 2017 06:42:28 +0200
Subject: [RFC PATCH 0/7] Hummingboard2 improvements
In-Reply-To: <CABdtJHutd5v4onVMMZdufnutzDWt5R3RE3XxicfHsTZkNUYXCg@mail.gmail.com>
References: <20170408143607.15928-1-dev@lynxeye.de>
 <1498234514.24585.3.camel@pengutronix.de>
 <20170624073031.GW4902@n2100.armlinux.org.uk>
 <20170708135907.GA23333@n2100.armlinux.org.uk>
 <CABdtJHutd5v4onVMMZdufnutzDWt5R3RE3XxicfHsTZkNUYXCg@mail.gmail.com>
Message-ID: <CABdtJHsGKrZ4R-kcikc9dsrO-CrZpRXzNEmQT4WgKJ=UZfDRCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 9, 2017 at 6:39 AM, Jon Nettleton <jon@solid-run.com> wrote:
>
>
>
> On Sat, Jul 8, 2017 at 3:59 PM, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
>>
>> On Sat, Jun 24, 2017 at 08:30:31AM +0100, Russell King - ARM Linux wrote:
>> > On Fri, Jun 23, 2017 at 06:15:14PM +0200, Lucas Stach wrote:
>> > > Hi Russell,
>> > >
>> > > it seems this is making no progress. If you don't mind I'm going to pick
>> > > up the patches from you hb2 branch and submit the whole series to Shawn,
>> > > so we can finally get things merged. Are you okay with this?
>> >
>> > If you remember from the reviews back in January of my patch set, Jon
>> > Nettleton promised to send me a replacement set of DT files that were
>> > properly licensed and updated along the lines of your patches in April.
>> > I'm still waiting...
>>
>> I've chased Jon a couple more times since (once today), and I'm feeling
>> that we're not getting anywhere.  I've now told him that we (SolidRun/
>> myself) are in danger of having this work replaced by others.  So, I'm
>> now adding Rabeeh to this thread.
>>
>>

Besides the licensing there are still a number of bugs that exist for
the device-tree files as they stand.  Most notably using the standard
regulator code for the SDHC device causes a hang on reboot with some
UHS cards.

Additionally we need to bring in the support for the SOM rev1.5 which
has been waiting on the TTY slave devices infrastructure to land.  We
have been trying to come up with a better solution than duplicating
all our device-tree files with a som revision however there doesn't
seem to be.  I would prefer to bring all the support in at once since
we are only shipping rev 1.5 soms at this point
