From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 4 Feb 2016 08:46:49 -0800
Subject: [PATCH v10 4/5] Watchdog: introduce ARM SBSA watchdog driver
In-Reply-To: <56B37E52.300@codeaurora.org>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-5-git-send-email-fu.wei@linaro.org>
 <20160204163101.GH17257@arm.com> <56B37E52.300@codeaurora.org>
Message-ID: <56B38079.10607@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2016 08:37 AM, Timur Tabi wrote:
> Will Deacon wrote:
>>> +static int sbsa_gwdt_keepalive(struct watchdog_device *wdd)
>>> >+{
>>> >+    struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>>> >+
>>> >+    /*
>>> >+    * Writing WRR for an explicit watchdog refresh.
>>> >+    * You can write anyting(like 0xc0ffee).
>>> >+    */
>>> >+    writel(0xc0ffee, gwdt->refresh_base + SBSA_GWDT_WRR);
>>> >+
>>> >+    return 0;
>>> >+}
>> You might get in trouble for that. 0xd09f00d is probably less poisonous.
>>
>> http://www.petpoisonhelpline.com/poison/caffeine/
>
> Any reason why we can't just keep it simple and write 0?

+1

Guenter
