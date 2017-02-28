From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 28 Feb 2017 10:42:45 +0100
Subject: [PATCH v3 6/6] ARM: davinci: add enable GPIOs for vpif capture to
 pdata-quirks
In-Reply-To: <2a617e15-5eab-6a24-9c21-e3ab9ecf3899@ti.com>
References: <1487772805-19021-1-git-send-email-bgolaszewski@baylibre.com>
 <1487772805-19021-7-git-send-email-bgolaszewski@baylibre.com>
 <2a617e15-5eab-6a24-9c21-e3ab9ecf3899@ti.com>
Message-ID: <CAMpxmJWdzBL5yEw4crS+vKnB393mj3uA4qgc=tjo9gTo770E=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-02-28 9:49 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Wednesday 22 February 2017 07:43 PM, Bartosz Golaszewski wrote:
>> On the da850-evm board we need to select the UI expander video capture
>> function to make vpif capture work. Add the relevant GPIOs to the
>> pdata-quirks.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Hmm, why do we need this despite enable-gpios in DT ?
>

I didn't look at the exact code path, but if we're using pdata-quirks,
the of_node in struct device passed to vpif_probe is NULL (one of the
reasons why we're not mixing DT and pdata for vpif subdevices
configuration etc.). So it seems that as long as we don't switch over
to DT entirely we need to have the GPIOs here as well.

Thanks,
Bartosz
