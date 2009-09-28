From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Mon, 28 Sep 2009 11:06:36 +0300
Subject: [PATCH 2/2] n2100: reduce power button timer to 1 Hz
In-Reply-To: <19134.29011.460366.960746@pilspetsen.it.uu.se>
References: <19134.29011.460366.960746@pilspetsen.it.uu.se>
Message-ID: <4AC06E8C.8090908@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Mikael Pettersson wrote:
> 10 Hz seems excessive, so this patch adds a compile-time option
> to reduce the polling frequency to 1 Hz.
> 
> (This change could possibly be handled via a kernel boot option,
> or even be made unconditional, but I opted for a compile-time
> option for now.)

I don't think there is need to have an option for this. With HZ also
round_jiffies() could be used, it doesn't need to be exact.

(I also think the code should check that the button is held down for
a while before doing the shutdown, but that's a different issue.)

A.
