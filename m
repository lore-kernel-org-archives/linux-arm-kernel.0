From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 20 Oct 2014 21:50:57 +0200
Subject: [PATCH v2 2/2] ARM: EXYNOS: Call regulator core suspend prepare
 and finish functions
In-Reply-To: <CAD=FV=WJfjhb9pfNhQwpToddR67NpA+m6kkj5oUVE5ewEhzvVQ@mail.gmail.com>
References: <1413454410-23396-1-git-send-email-javier.martinez@collabora.co.uk>	<1413454410-23396-3-git-send-email-javier.martinez@collabora.co.uk>	<CAD=FV=UtwNjyx56QtRrEo=jbX_PeMRAYZJVXzxqeS-vs4JyGRg@mail.gmail.com>	<54453F2E.1080401@collabora.co.uk>
 <CAD=FV=WJfjhb9pfNhQwpToddR67NpA+m6kkj5oUVE5ewEhzvVQ@mail.gmail.com>
Message-ID: <544567A1.2060006@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Rafael Wysocki to cc as Suspend-to-RAM maintainer]

On 10/20/2014 07:36 PM, Doug Anderson wrote:
> Javier,
> 
> On Mon, Oct 20, 2014 at 9:58 AM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
>>> It turns out that regulator_suspend_finish() actually returns an error
>>> code.  Could you print a warning if you see it?
>>>
>>
>> Yes, I noticed this when looking at Chris patch for Rockchip but didn't re-spin
>> because I'm not sure anymore if this is the right solution. I mean, if is
>> correct to add the same calls on every platform or if the regulator suspend
>> prepare and finish functions should be called from the suspend core instead.
>>
>> For example calling regulator_suspend_prepare() from platform_suspend_prepare()
>> [0] will have the advantage of passing the correct suspend_state_t state instead
>> of hard-coding PM_SUSPEND_MEM and will make the regulator suspend states to work
>> on all platforms.
> 
> Yes.  If we can get this added to the core that would be better.
> 

Agreed, let's see what Rafael says about it.

> I guess I was just trying to follow the suggestion that was in the
> regulator code:
> http://lxr.free-electrons.com/source/drivers/regulator/core.c#L3699
> that says "This will usually be called by machine suspend code prior
> to supending."
> 
> -Doug
> 

I see, but still I feel as if it may be a lot of duplication since most
platforms will likely want to call the regulator core suspend prepare
and finish functions. Maybe it can be added as a Kconfig option so each
platform can choose at the config level if they want those to be called?

Best regard,
Javier
