From: timo.kokkonen@offcode.fi (Timo Kokkonen)
Date: Mon, 27 Apr 2015 08:50:02 +0300
Subject: [PATCHv7 7/8] watchdog: omap_wdt: Fix memory leak on probe fail
In-Reply-To: <553D0503.7050207@roeck-us.net>
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
 <1429701102-22320-8-git-send-email-timo.kokkonen@offcode.fi>
 <553D0503.7050207@roeck-us.net>
Message-ID: <553DCE0A.6010906@offcode.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.04.2015 18:32, Guenter Roeck wrote:
> On 04/22/2015 04:11 AM, Timo Kokkonen wrote:
>> Structures allocated on the beginning of the probe function must be
>> freed in case of failure.
>
> Really ? The functions are allocated with devm_kzalloc.
> It might be useful to introduce an error on purpose, have the code
> jump to your new label, and observe what happens.

Interesting. I wasn't aware of devm_kzalloc. I will have to remove this 
patch from the series and rework the another omap patch to apply without 
this. Thanks!

-Timo
