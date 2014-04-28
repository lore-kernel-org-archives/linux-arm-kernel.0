From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 29 Apr 2014 00:19:34 +0800
Subject: [linux-sunxi] Re: [PATCH 1/7] gpiolib: gpiolib-of: Implement
 device tree gpio-names based lookup
In-Reply-To: <CAAVeFuL7B7kVw7ME=Vo_snhG27aBphKO8Uzvzen1gyD=R2ETNA@mail.gmail.com>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
 <1397544101-18135-2-git-send-email-wens@csie.org>
 <CACRpkdZDjC1KxM2yJqsgpg2MxBamX1EObsuahB-2c+ShuBXm8A@mail.gmail.com>
 <CAAVeFuL7B7kVw7ME=Vo_snhG27aBphKO8Uzvzen1gyD=R2ETNA@mail.gmail.com>
Message-ID: <CAGb2v64rs4UYMbQ--i=pcuuORVneozDpucCeHQKE4Qn7+qSCdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 9:49 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Wed, Apr 23, 2014 at 12:02 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> On Tue, Apr 15, 2014 at 8:41 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>>
>>> This patch provides of_get_gpiod_flags_by_name(), which looks up GPIO
>>> phandles by name only, through gpios/gpio-names, and not by index.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>
>> Like Alexandre I have no strong opinion on this alternative scheme.
>
> Yeah this new lookup scheme probably does no harm, but I think it
> should be a little bit more motivated as it is, after all, introducing
> more potential confusion for DT users.
>
> It does not look like this new lookup scheme is necessary to Chen-Yu's
> patchset and that he could as well have used the current one. Right
> now there is only one way to define GPIOs - if we introduce a second
> one, then which one should new DT users choose? Which one looks
> better? I can already endless fights taking place over this.

I will pull out the two patches.

> Does this new lookup help with some of the existing problems we have
> like ACPI/DT lookup compatibility?

I hope they will be compatible with ACPI named gpios, whenever support
for ACPI named properties extension lands. But that really depends on
the ACPI implementation. For now I think it's best that I just hold on
to these. We can revisit the discussion later if needed.

> I just need to be given one practical reason to give my ack.


Thanks
ChenYu
