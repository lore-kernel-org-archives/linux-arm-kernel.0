From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 10 Feb 2013 01:15:33 +0800
Subject: [PATCH v7 06/15] gpio: find gpio base by ascend order
In-Reply-To: <20130209134540.BA5EB3E30EC@localhost>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-7-git-send-email-haojian.zhuang@linaro.org>
 <20130209134540.BA5EB3E30EC@localhost>
Message-ID: <CAD6h2NT2Luk0KSewr-oaPeJaUpfxiohX9x_AYYLasDAtijvtzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 February 2013 21:45, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Fri, 18 Jan 2013 15:31:10 +0800, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
>> gpiochip_find_base() always tries to find valid gpio with descend order.
>> It's inconvient if gpio information is passing from DTS. Now try to find
>> valid gpio with ascend order.
>
> Why is it more convenient? Just to make the numbers smaller? The reason
> it uses a descending search is to mimimize the possibility of collision
> with fixed GPIO numbers.
>
> g.
>

I tried to parse global gpio number dynamically from DT, so I also used
gpiochip_find_base() to seek gpio number. If it's descending order, all the
gpio number are not also descending order. It will be inconvenient for
linking it to SoC datasheet & schematic. Since changing it to ascending
order may break user space application, Linus NACKed.

Now I'm trying to use fixed gpio number from machine driver.

Regards
Haojian
