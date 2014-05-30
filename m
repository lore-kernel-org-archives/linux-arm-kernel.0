From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 30 May 2014 10:17:05 +0200
Subject: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
In-Reply-To: <20140528164326.GB5099@sirena.org.uk>
References: <53824294.1090609@redhat.com>
 <20140526103807.GV22111@sirena.org.uk> <538321AB.4050006@redhat.com>
 <20140526142225.GF22111@sirena.org.uk> <538356DA.7090302@redhat.com>
 <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
 <53838023.2080807@redhat.com>
 <CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
 <5385AF94.90004@redhat.com> <5385CCE6.9070204@gmail.com>
 <20140528164326.GB5099@sirena.org.uk>
Message-ID: <53883E81.3060109@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/28/2014 06:43 PM, Mark Brown wrote:
> On Wed, May 28, 2014 at 01:47:50PM +0200, Tomasz Figa wrote:

<snip>

>> IMHO, all we need here is a way to tell the MMC (or HSIC) core when to
>> look for a new device and when not (e.g. power down the host controller
>> completely). Anything else, including proper power sequencing is up to
>> the platform driver of such non-discoverable device - it's only its host
>> interface that is discoverable when enabled. I believe this simplistic
>> approach would lead to much less new code added, better reusability of
>> code (power sequencing independent of host interface) and no need to
>> create overly generic code, which usually turns out to be not generic
>> enough.
> 
> We then have the problem of working out where that platform driver comes
> from, for many of these buses the device can be completely described as
> just a device on the parent bus with some resources connected.

Right, I think what we should do is focus on the DT description for this
first and then worry about the implementation later.

I believe that at the DT level this all should be represented as a child-node
under the host controller. Following that reasoning it makes perfect sense
to just focus on mmc for now, while keeping in mind that it would be nice if
what comes out of this will be re-usable.

I've done a detailed, updated proposal for the mmc case (with admittedly
some implementation comments in there) in my last mail, but unfortunately
I've seen little response to that. Can people please reply to my
proposal where we've 2 levels of child nodes, one per mmc slot, and then the
slot nodes has card / sdio-func child nodes, see my last mail.

Regards,

Hans
