From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 7 Dec 2017 11:37:15 +0800
Subject: [PATCH v3 04/15] dt-bindings: display: sun4i-drm: Add A83T
 pipeline
In-Reply-To: <20171206215922.vtsa4xqa2e5xz7cp@rob-hp-laptop>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
 <3762a8428aaf207e80ae86d4db2e50473576bb6d.1512486553.git-series.maxime.ripard@free-electrons.com>
 <20171206215922.vtsa4xqa2e5xz7cp@rob-hp-laptop>
Message-ID: <CAGb2v64q9LMKWFvAVK66q3uz5f9G9NSO-p99YEv5ejK4Qs=x-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 5:59 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Dec 05, 2017 at 04:10:16PM +0100, Maxime Ripard wrote:
>> The A83T has two video pipelines in parallel that looks quite similar to
>> the other SoCs.
>>
>> The video planes are handled through a controller called the mixer, and the
>> video signal is then passed to the timing controller (TCON).
>>
>> And while there is two instances of the mixers and TCONs, they have a
>> significant number of differences. The TCONs are quite easy to deal with,
>> one is supposed to generate TV (in the broader term, so including things
>> like HDMI) signals, the other one LCD (so RGB, LVDS, DSI) signals. And
>> while they are called TCON0 and TCON1 in the A83t datasheet, newer SoCs
>> call them TCON-TV and TCON-LCD, which seems more appropriate.
>>
>> However, the mixers differ mostly by their capabilities, with some features
>> being available only in the first one, or the number of planes they expose,
>> but also through their register layout. And while the capabilities could be
>> represented as properties, the register layout differences would need to
>> express all the registers offsets as properties, which is usually quite
>> bad. Especially since documentation on that hardware block is close to
>> non-existant and we don't even have the list of all those registers in the
>> first place.
>>
>> So let's call them mixer 0 and 1 in our compatibles, even though the name
>> is pretty bad...
>>
>> At the moment, we only have tested the code on a board that has a single
>> display output, so we're leaving the tcon-tv and mixer1 out.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
