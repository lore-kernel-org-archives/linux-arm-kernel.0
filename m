From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 19 Oct 2017 12:25:30 +0200
Subject: [PATCH] firmware: meson-sm: use generic compatible
In-Reply-To: <20171017204959.kfbhn2yxhv2sb5qg@rob-hp-laptop> (Rob Herring's
 message of "Tue, 17 Oct 2017 15:50:00 -0500")
References: <20171012134743.10625-1-jbrunet@baylibre.com>
 <20171017204959.kfbhn2yxhv2sb5qg@rob-hp-laptop>
Message-ID: <7h8tg7zb6t.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> On Thu, Oct 12, 2017 at 03:47:43PM +0200, Jerome Brunet wrote:
>> The meson secure monitor seems to be compatible with more SoCs than
>> initially thought. Let's use the most generic compatible he have in
>> DT instead of the gxbb specific one
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/firmware/meson/meson_sm.txt | 4 ++--
>>  drivers/firmware/meson/meson_sm.c                             | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> Seems like a pointless, not backwards compatible change to me.

I've verified that it's backwards compatible with existing upstream DTs.

> end, it's just a string to match on. Who cares what the string is.

As platform maintiner, I very much care what the strings are and I want
it to be coherent with the platform generic names, and I want the
SoC-specific strings to correspond to the actual SoC names.

Kevin
