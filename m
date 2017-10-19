From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Oct 2017 16:18:17 -0500
Subject: [PATCH] firmware: meson-sm: use generic compatible
In-Reply-To: <7h8tg7zb6t.fsf@baylibre.com>
References: <20171012134743.10625-1-jbrunet@baylibre.com>
 <20171017204959.kfbhn2yxhv2sb5qg@rob-hp-laptop>
 <7h8tg7zb6t.fsf@baylibre.com>
Message-ID: <CAL_JsqJ-XAqMA_zjxrJNAtysQsXzmWYUFqLJtKX2wUJ0oebtuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 5:25 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> On Thu, Oct 12, 2017 at 03:47:43PM +0200, Jerome Brunet wrote:
>>> The meson secure monitor seems to be compatible with more SoCs than
>>> initially thought. Let's use the most generic compatible he have in
>>> DT instead of the gxbb specific one
>>>
>>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>>> ---
>>>  Documentation/devicetree/bindings/firmware/meson/meson_sm.txt | 4 ++--
>>>  drivers/firmware/meson/meson_sm.c                             | 4 ++--
>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> Seems like a pointless, not backwards compatible change to me.
>
> I've verified that it's backwards compatible with existing upstream DTs.

Perhaps if you all are documenting only what the driver uses, not what
the dts can have as Jerome said.

>> end, it's just a string to match on. Who cares what the string is.
>
> As platform maintiner, I very much care what the strings are and I want
> it to be coherent with the platform generic names, and I want the
> SoC-specific strings to correspond to the actual SoC names.

The most specific compatible should be, absolutely. The fallbacks can
be anything really. Ideally, they are the compatible string for the
1st SoC with "the same" compatible IP. Could be another vendor
entirely even because mergers happen.

Rob
