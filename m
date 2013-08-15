From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Aug 2013 22:11:47 +0200
Subject: [PATCH 5/5] pinctrl: imx: Use struct type for pins
In-Reply-To: <20130815050842.GF26614@pengutronix.de>
References: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
 <1376050854-3303-6-git-send-email-s.hauer@pengutronix.de>
 <CACRpkdZk4jz3dg6aoZqsMT5VXJUQxwrZOyAVLCU3UsExAXChAA@mail.gmail.com>
 <20130815050842.GF26614@pengutronix.de>
Message-ID: <CACRpkdZ6Ba=54cc036G34NJdpEhCXiCQpFnKi_eZFXumQSkeog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 7:08 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Aug 14, 2013 at 10:41:20PM +0200, Linus Walleij wrote:
>> On Fri, Aug 9, 2013 at 2:20 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>>
>> > The i.MX pinctrl driver uses 5 different arrays for storing the
>> > informations for pins. This requires five allocations. Instead,
>> > use a struct type which is more cache friendly, readable and
>> > requires less allocations. One array of integers is still needed
>> > since the pinctrl framework forces us to maintain it.
>> > This also adds checks whether the allocations are succesful which
>> > were missing.
>> >
>> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>
>> Hm appears to be dependent on 4/5 so can't apply this one
>> in isolation ... but it looks good.
>>
>> Would be nice to have a handshake from Shawn and/or Dong
>> on these patches BTW.
>
> What do you mean with handshake? Shawn acked the series.

Oh he did? I just haven't seen that message ... I have to look
around.

But hm, 5/5 still does not apply cleanly after applying 4/5,
I guess I have some alien patch in the pinctrl tree that you
don't have, can you try to create a rebased version of this
one patch on to of my "devel" branch?

Yours,
Linus Walleij
