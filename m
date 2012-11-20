From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 20 Nov 2012 15:10:06 +0530
Subject: [PATCH 1/3] CLK: uninline clk_prepare() and clk_unprepare()
In-Reply-To: <20121120093242.GK3290@n2100.arm.linux.org.uk>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353403339-11679-2-git-send-email-dmitry.torokhov@gmail.com>
 <20121120093242.GK3290@n2100.arm.linux.org.uk>
Message-ID: <CAKohponif3xf8ymtZ4-vv8TEj74C=9_Me5osMV4dcwSfUjPZAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2012 15:02, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 20, 2012 at 01:22:17AM -0800, Dmitry Torokhov wrote:
>> We'll need to invoke clk_unprepare() via a pointer in our devm_*
>> conversion so let's uninline the pair.
>
> NAK.  This breaks non-common clock using implementations.

Hi Russell,

Dummy routines for non-common clock are still there. Sorry, couldn't get
why this will break those platforms:

+static inline int clk_prepare(struct clk *clk)
+{
+       might_sleep();
+       return 0;
+}
+
+static inline void clk_unprepare(struct clk *clk)
+{
+       might_sleep();
+}
+

--
viresh
