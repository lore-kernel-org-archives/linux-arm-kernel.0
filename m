From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Mar 2012 11:19:25 -0600
Subject: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl
 interaction
In-Reply-To: <20120312163212.70E283E07B0@localhost>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
 <CACRpkdbPeVBv5VWefDvib5HmGF0K2gT79Mx7g-yviyQj33+Z-w@mail.gmail.com>
 <20120312163212.70E283E07B0@localhost>
Message-ID: <4F5E301D.9030700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2012 10:32 AM, Grant Likely wrote:
> On Tue, 21 Feb 2012 11:46:03 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Mon, Feb 20, 2012 at 7:27 AM, Stephen Warren <swarren@nvidia.com> wrote:
>>
>>> Update gpio.txt based on recent discussions regarding interaction with the
>>> pinctrl subsystem.
>>>
>>> Previously, gpio_request() was described as explicitly not performing any
>>> required mux setup operations etc.
>>>
>>> Now, gpio_request() is explicitly as explicitly performing any required mux
>>> setup operations where possible. In the case it isn't, platform code is
>>> required to have set up any required muxing or other configuration prior to
>>> gpio_request() being called, in order to maintain the same semantics.
>>>
>>> This is achieved by gpiolib drivers calling e.g. pinctrl_request_gpio() in
>>> their .request() operation.
>>>
>>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Grant can you take this one? I'd prefer for you to have a look at
>> it as well.
> 
> I've taken this one, but left the 2nd for Olof.

Grant, did you take V2 of this patch? I assume not since you replied to V1.

For reference, that's:
http://lkml.org/lkml/2012/3/5/533

Thanks.
