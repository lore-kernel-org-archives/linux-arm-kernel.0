From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 20 Oct 2014 22:10:54 +0200
Subject: [PATCH v2 2/2] ARM: EXYNOS: Call regulator core suspend prepare
 and finish functions
In-Reply-To: <20141020195641.GT18557@sirena.org.uk>
References: <1413454410-23396-1-git-send-email-javier.martinez@collabora.co.uk>
 <1413454410-23396-3-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=UtwNjyx56QtRrEo=jbX_PeMRAYZJVXzxqeS-vs4JyGRg@mail.gmail.com>
 <54453F2E.1080401@collabora.co.uk>
 <CAD=FV=WJfjhb9pfNhQwpToddR67NpA+m6kkj5oUVE5ewEhzvVQ@mail.gmail.com>
 <544567A1.2060006@collabora.co.uk> <20141020195641.GT18557@sirena.org.uk>
Message-ID: <54456C4E.9090303@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 10/20/2014 09:56 PM, Mark Brown wrote:
> On Mon, Oct 20, 2014 at 09:50:57PM +0200, Javier Martinez Canillas wrote:
>> On 10/20/2014 07:36 PM, Doug Anderson wrote:
> 
>> > I guess I was just trying to follow the suggestion that was in the
>> > regulator code:
>> > http://lxr.free-electrons.com/source/drivers/regulator/core.c#L3699
>> > that says "This will usually be called by machine suspend code prior
>> > to supending."
> 
>> I see, but still I feel as if it may be a lot of duplication since most
>> platforms will likely want to call the regulator core suspend prepare
> 
> Note that architectures are an example of a platform.  It really depends
> what's responsible for final poweroff, we want this called as late as we
> possibly can.
> 

Got it. Thanks for the explanation.

>> and finish functions. Maybe it can be added as a Kconfig option so each
>> platform can choose at the config level if they want those to be called?
> 
> No, that's obviously not going to do anything useful for multiplatform.
> 

Ok, then let's keep to do it per-platform as is proposed on $subject for
Exynos and what Chris proposed for Rockchip in [0] since it seems that's
the place where these calls belong.

Best regards,
Javier

[0]: http://www.spinics.net/lists/devicetree/msg53640.html
