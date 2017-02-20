From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Mon, 20 Feb 2017 11:04:52 +0100
Subject: [PATCH] arm64: traps: Mark __le16, __le32,
 __user variables properly
In-Reply-To: <148758047729.2988.16966413648865610904@sboyd-linaro>
References: <20170217165112.17512-1-stephen.boyd@linaro.org>
 <20170219015808.2vc2kvpde7nlrey4@macbook.local>
 <148758047729.2988.16966413648865610904@sboyd-linaro>
Message-ID: <CAExDi1RAFMNgN66XAmhds9bAM1OE71kZjKQc8zkPA2zcjv5GcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2017 at 9:47 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> Quoting Luc Van Oostenryck (2017-02-18 17:58:09)
>> On Fri, Feb 17, 2017 at 08:51:12AM -0800, Stephen Boyd wrote:
>> > arch/arm64/kernel/traps.c:567:10: warning: Initializer entry defined twice
>> > arch/arm64/kernel/traps.c:568:10:   also defined here
>> This one I find strange. Can you tell which are those two entries?
>>
>
> This is:
>
>  static const char *esr_class_str[] = {
>          [0 ... ESR_ELx_EC_MAX]          = "UNRECOGNIZED EC",
>          [ESR_ELx_EC_UNKNOWN]            = "Unknown/Uncategorized",
>
> where we initialize the entire array to an "unknown" value once, and
> then fill in the known values after that. This isn't a very common
> pattern, but it is used from time to time to avoid having lots of lines
> to do the same thing.

I see, yes can be handy but indeed spaese doesn't know about it yet.

Luc
