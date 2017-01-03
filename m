From: andi@etezian.org (Andi Shyti)
Date: Tue, 3 Jan 2017 23:40:56 +0900
Subject: [PATCH 3/4] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
In-Reply-To: <ff876454-b49f-3d63-d76e-012dd303b0e7@osg.samsung.com>
References: <CGME20170103075734epcas5p43a9743131f63affd0a438d2ed342f22e@epcas5p4.samsung.com>
 <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <1483430237-26823-4-git-send-email-jcsing.lee@samsung.com>
 <CAJKOXPev9m07_dQWAvJ+=MKnbT0TFERKOtjWUDU+WXdGAiRyDA@mail.gmail.com>
 <20170103095842.h3hl64amje4qv4ts@gangnam.samsung>
 <CAJKOXPeEE1VwAUSAOpfyX+t58zKeAT1fe3ybp0BoQiiDBb4Uqg@mail.gmail.com>
 <20170103102548.73jg6qddlcthe2mu@gangnam.samsung>
 <CAGTfZH3ez4DPTE7-bDeayjhSGxJ_8Mj1MQz1M7O1qhwOGOnmMQ@mail.gmail.com>
 <20170103115530.zhjwn7bzmqmumy23@gangnam.samsung>
 <ff876454-b49f-3d63-d76e-012dd303b0e7@osg.samsung.com>
Message-ID: <20170103144056.4ft2ohmhgmezeney@jack.zhora.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> FWIW, I also agree with Chanwoo that the difference is too small to
> need a common .dtsi file.

in principle I don't like "switching on and off" properties by
overwriting them with "status = disable", unless it's really
necessary (and this case is not). Even for small differences. It
makes the DTS harder to read and duplicates nodes with different
values throughout the DTS include chain.

In my opinion this approach should be discouraged.

Besides, there are other overwritten differences in tm2e.dts that
I think should be separated as well. The "common" file approach is
widely used in arm/boot/dts/exynos* files.

The "status = disable" looks to me more like a temporary hack
rather than a permanent solution.

In any case, still up to you :)

Andi
