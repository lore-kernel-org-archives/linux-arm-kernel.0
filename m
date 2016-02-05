From: fu.wei@linaro.org (Fu Wei)
Date: Fri, 5 Feb 2016 16:52:55 +0800
Subject: [PATCH v10 4/5] Watchdog: introduce ARM SBSA watchdog driver
In-Reply-To: <56B38079.10607@roeck-us.net>
References: <1454519923-25230-1-git-send-email-fu.wei@linaro.org>
 <1454519923-25230-5-git-send-email-fu.wei@linaro.org>
 <20160204163101.GH17257@arm.com> <56B37E52.300@codeaurora.org>
 <56B38079.10607@roeck-us.net>
Message-ID: <CADyBb7u1rN9f8A+eeC4-BgLyjnhYbgyQfepRDy0OmMmMWxD6sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 5 February 2016 at 00:46, Guenter Roeck <linux@roeck-us.net> wrote:
> On 02/04/2016 08:37 AM, Timur Tabi wrote:
>>
>> Will Deacon wrote:
>>>>
>>>> +static int sbsa_gwdt_keepalive(struct watchdog_device *wdd)
>>>> >+{
>>>> >+    struct sbsa_gwdt *gwdt = to_sbsa_gwdt(wdd);
>>>> >+
>>>> >+    /*
>>>> >+    * Writing WRR for an explicit watchdog refresh.
>>>> >+    * You can write anyting(like 0xc0ffee).
>>>> >+    */
>>>> >+    writel(0xc0ffee, gwdt->refresh_base + SBSA_GWDT_WRR);
>>>> >+
>>>> >+    return 0;
>>>> >+}
>>>
>>> You might get in trouble for that. 0xd09f00d is probably less poisonous.
>>>
>>> http://www.petpoisonhelpline.com/poison/caffeine/
>>
>>
>> Any reason why we can't just keep it simple and write 0?
>
>
> +1

yes, we can, just "0" would be fine, will do.

Thanks :-)

>
> Guenter
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
