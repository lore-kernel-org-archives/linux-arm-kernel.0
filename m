From: dianders@chromium.org (Doug Anderson)
Date: Wed, 30 Sep 2015 16:58:43 -0700
Subject: [PATCH] ARM: dts: Add Exynos5250 Snow Rev5+ support
In-Reply-To: <560C73EC.40608@samsung.com>
References: <1443527855-434-1-git-send-email-javier@osg.samsung.com>
 <560B2D29.5060707@samsung.com>
 <CAD=FV=VfGeWdynFd+5YqnRGn+jsC0G_2VhTm1FKsR5o2WpcH1A@mail.gmail.com>
 <560C73EC.40608@samsung.com>
Message-ID: <CAD=FV=WmqDSbnA8OWL00WS-qc9A4wCpkgxHhLBW3qEE=SkzupA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 30, 2015 at 4:44 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
>> Switching the default meaning of "google,snow" to Rev5 is probably not
>> something we'd ever want to do, since it could confuse "rev3" boards
>> (which should be serviced by the rev4 dts).  From comments in the
>> Chrome OS tree:
>>
>> In the "rev4" DTS:
>>          * - Any real rev 0-3 boards in the field will match "google,snow",
>>          *   since older U-Boots don't look for a revision specific device tree.
>>          * - Any real rev 4 boards in the field will match "google,snow-rev4"
>>          *   first.  If that's not present they will pick the first
>>          *   "google,snow" device tree that they find (ignoring the kernel
>>          *   ordering).
>>
>> In the "rev5" DTS:
>>          * - Purposely don't add "google,snow" so old firmware (which didn't
>>          *   include a -revN suffix) won't pick this one.
>
> These are requirements written somewhere in the downstream tree... not
> in upstream. Have in mind that someone may not be using Chrome OS on
> Chromebook but custom U-Boot and different distro.
>
> You cannot expect that everyone will new some requirements of some
> downstream OS. If you need such requirements, write them in bindings
> documentation *in the upstream*.

Agreed, which is why I bring it up here.  I think Javier wasn't aware
of these when he sent up his patch.  I believe when he adds the
bindings docs he'll put this information.

Previously rev5 wasn't supported upstream and I believe rev5 didn't
even exist when the upstream stuff was submitted.

-Doug
