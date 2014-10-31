From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 31 Oct 2014 14:07:54 +0100
Subject: [PATCH v3 01/14] mfd: max77686/802: Map regulator driver to its
 own of_node
In-Reply-To: <20141031122330.GP18557@sirena.org.uk>
References: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
 <1414668053-31370-2-git-send-email-k.kozlowski@samsung.com>
 <20141031122330.GP18557@sirena.org.uk>
Message-ID: <1414760874.7318.15.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pi?, 2014-10-31 at 12:23 +0000, Mark Brown wrote:
> On Thu, Oct 30, 2014 at 12:20:40PM +0100, Krzysztof Kozlowski wrote:
> > Add of_compatible fields for max77686 and max77802 regulator drivers.
> > The driver's node should be the same as voltage-regulators node. This
> > simplifies parsing of regulators init data from DTS.
> 
> No, this is broken.  You're introducing an ABI break that conveys no
> additional information, I can't see any reason why this should make it
> simpler to parse init data (you've certainly not articulated one in the
> changelog here) but even if it did you are changing the ABI incompatibly
> and convenience isn't a good reason to do that.

The ABI won't be broken - both drivers would work fine with old and new
DTB. However I agree that I should justify this more...

Javier and you explained me using parent's device for rdev->dev so I
think this change won't be needed and I'll just drop it.

Thank you for feedback.

> I'm getting very frustrated with what's going on with these drivers,
> there seem to be a lot of rather large sets of patches spawning lots of
> discussion but also frequent review problems and very little actually
> getting merged (look at the set of changes in the past few merge windows
> for example).  There's something going wrong here.

If I over-spammed you, then I am deeply sorry.

Best regards,
Krzysztof
