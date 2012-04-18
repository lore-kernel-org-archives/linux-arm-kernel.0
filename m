From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 18 Apr 2012 22:36:05 +0200
Subject: [PATCH 1/9] ARM: OMAP3+: voltage: export functions to
 plat/voltage.h
In-Reply-To: <87y5ptkl0u.fsf@ti.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
 <1332173578-27422-2-git-send-email-j-pihet@ti.com>
 <87y5ptkl0u.fsf@ti.com>
Message-ID: <CAORVsuWBHVhHnqBeKQ8hb2p+UsRP84O-Hq=bXYQv2wBJyfELGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Adding Keerthy J

On Wed, Apr 18, 2012 at 7:27 PM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Jean,
>
> jean.pihet at newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Move some functions from mach-omap2/ dir to the plat/ dir.
>> The SmartReflex class driver is a user of the basic voltage domains
>> functions (enable, disable, reset).
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>
> Rather than expose the VP functions directly, how about adding a new API
> at the voltdm layer to start/stop AVS. ?Maybe something like:
>
> ?voltdm_avs_start(struct voltagedomain *voltdm)
> ?voltdm_avs_stop(struct voltagedomain *voltdm)
>
> These will internally just call VP enable/disable for now, but we may
> have more to add to these in the future to support other SR classes.
Agree.
That would be a first step in the definition of the API between SR and
VP. Implementing other SR classes might require more than that, this
is still under investigation for now.

>
> Kevin
>

Thanks for reviewing,
Jean
