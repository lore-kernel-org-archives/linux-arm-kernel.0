From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 10 Oct 2015 12:08:45 +0900
Subject: [RFT 0/3] usb: usb3503: Fix probing on Arndale board (missing phy)
In-Reply-To: <7hoag797gk.fsf@deeprootsystems.com>
References: <1444177807-15524-1-git-send-email-k.kozlowski@samsung.com>
 <7hoag797gk.fsf@deeprootsystems.com>
Message-ID: <5618813D.20502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 10.10.2015 o 04:18, Kevin Hilman pisze:
> Hi Krzystof,
> 
> Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:
> 
>> Introduction
>> ============
>> This patchset tries to fix probing of usb3503 on Arndale board
>> if the Samsung PHY driver is probed later (or built as a module).
>>
>> *The patchset was not tested on Arndale board.*
>> I don't have that board. Please test it and say if the usb3503 deferred probe
>> works fine and the issue is solved.
> 
> FYI... I built this series on top of  next-20151009 and using
> exynos_defconfig.  I booted it on my arndale, and I still don't see the
> networking come up.  Full boot log attached.

+cc Tyler

Kevin,
Thanks for testing but I am not sure if this boot failure is related to
the patch. I mean if the patch should fix this particular boot failure.
The board stopped to boot after enabling DWC2 and network USB gadget:
http://www.spinics.net/lists/linux-samsung-soc/msg47009.html

The boot log shows that usb3503 was probed but asix network adapter was
not. I wonder how these things are related to each other...

Nevertheless it would be difficult to debug the issue without the
Arndale board. :)

Best regards,
Krzysztof
