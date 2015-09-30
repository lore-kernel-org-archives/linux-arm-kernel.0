From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 01 Oct 2015 08:44:44 +0900
Subject: [PATCH] ARM: dts: Add Exynos5250 Snow Rev5+ support
In-Reply-To: <CAD=FV=VfGeWdynFd+5YqnRGn+jsC0G_2VhTm1FKsR5o2WpcH1A@mail.gmail.com>
References: <1443527855-434-1-git-send-email-javier@osg.samsung.com>
 <560B2D29.5060707@samsung.com>
 <CAD=FV=VfGeWdynFd+5YqnRGn+jsC0G_2VhTm1FKsR5o2WpcH1A@mail.gmail.com>
Message-ID: <560C73EC.40608@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.10.2015 01:17, Doug Anderson wrote:
> Hi,
> 
> On Tue, Sep 29, 2015 at 5:30 PM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> Now the exynos5250-snow.dts means in fact Rev4... but there is no
>> information in DTS about it. I think adding compatible
>> "google,snow-rev4" makes sense:
>> 1. For informational purposes (this could be also handled with a comment).
>> 2. Later one could decide to switch the default meaning of "google,snow"
>> to Rev5 and the real compatible (rev4) will be there already.
>>
>> Could you add the new compatible and fix patch issues pointed by Doug?
> 
> Looks like everything got applied, but just for the record:
> 
> Switching the default meaning of "google,snow" to Rev5 is probably not
> something we'd ever want to do, since it could confuse "rev3" boards
> (which should be serviced by the rev4 dts).  From comments in the
> Chrome OS tree:
> 
> In the "rev4" DTS:
>          * - Any real rev 0-3 boards in the field will match "google,snow",
>          *   since older U-Boots don't look for a revision specific device tree.
>          * - Any real rev 4 boards in the field will match "google,snow-rev4"
>          *   first.  If that's not present they will pick the first
>          *   "google,snow" device tree that they find (ignoring the kernel
>          *   ordering).
> 
> In the "rev5" DTS:
>          * - Purposely don't add "google,snow" so old firmware (which didn't
>          *   include a -revN suffix) won't pick this one.

These are requirements written somewhere in the downstream tree... not
in upstream. Have in mind that someone may not be using Chrome OS on
Chromebook but custom U-Boot and different distro.

You cannot expect that everyone will new some requirements of some
downstream OS. If you need such requirements, write them in bindings
documentation *in the upstream*.

Best regards,
Krzysztof
