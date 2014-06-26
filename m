From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 26 Jun 2014 14:15:42 +0200
Subject: [PATCH] ARM: integrator: fix OF-related regression
In-Reply-To: <CAL_Jsq+Us51c-6+kP5Y+aML-HPV-=9SooPepD6u13xyrvDfcKw@mail.gmail.com>
References: <1403611687-23512-1-git-send-email-linus.walleij@linaro.org>
 <CAL_Jsq+Us51c-6+kP5Y+aML-HPV-=9SooPepD6u13xyrvDfcKw@mail.gmail.com>
Message-ID: <CACRpkdZr6T65zOmxy9mQdeapMfu=nwfcXRtufb5DU5NO+vwU7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 3:06 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Jun 24, 2014 at 7:08 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> Commit 07e461cd7e73a84f0e3757932b93cc80976fd749
>> "of: Ensure unique names without sacrificing determinism"
>> caused a boot failure regression on the Integrator machines.
>>
>> The problem is probably caused by fiddling too much with
>> the device tree population in the OF init function, such
>> as passing the SoC bus device as parent when populating
>> the device tree.
>>
>> This patch fixes the problem by:
>>
>> - Avoiding to explicitly look up the tree root
>> - Look up devices needed before device population from
>>   the match only, passing NULL as root
>> - Passing NULL as root and parent when calling
>>   of_platform_populate()
>
> Just curious, I don't see how this fixes booting for Integrator. Where
> exactly does boot fail?

It fails by failing to populate the devicetree somehow. I don't
have the proper debugging needs, I just trial-and-horror-fixed
it by making the board init similar to other platforms :-/

Yours,
Linus Walleij
