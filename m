From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Sep 2012 21:51:25 -0700
Subject: [PATCH 2/5] Documentation: add description of DT binding for the
 gpio-mvebu driver
In-Reply-To: <CACRpkda=BHEWLx3q7kv_SSxg5j2=KTE_1ga4uNDxUx0M3_nm1g@mail.gmail.com>
References: <1344691906-15985-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1344691906-15985-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120827215133.GA7431@lumpy>
 <CACRpkda=BHEWLx3q7kv_SSxg5j2=KTE_1ga4uNDxUx0M3_nm1g@mail.gmail.com>
Message-ID: <CAOesGMjqX8emWW5ie6fdstA3Oo9BYTM0wcD4Pjo1J+Obm6Xx1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 2, 2012 at 12:33 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Aug 27, 2012 at 11:53 PM, Olof Johansson <olof@lixom.net> wrote:
>> Hi,
>>
>> On Sat, Aug 11, 2012 at 03:31:43PM +0200, Thomas Petazzoni wrote:
>>> +- gpio-controller: marks the device node as a gpio controller
>>> +
>>> +- ngpios: number of GPIOs this controller has
>>> +
>>> +- #gpio-cells: Should be one. It is the pin number.
>>
>> Most platforms will hit a need to encode polarity of the GPIO, in
>> particular on inputs. Having an extra cell for flags is quite useful.
>
> Isn't that surplus in this case since this driver has a proper
> pinctrl backend controlling such stuff? I don't really like
> pinctrl portions of GPIOs being showeled into the GPIO
> actually. Or am I just getting this wrong...?

Ah, yes, true. Last time I had to add this was for a platform that
lacked pinctrl bindings (exynos).

I guess it doesn't hurt to add the flag since it might be used on
other OSes that have a gpio driver but not a pinctrl one, but that's a
pretty far corner case, no need to revise for it.


-Olof
