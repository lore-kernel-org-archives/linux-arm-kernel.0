From: davidb@codeaurora.org (David Brown)
Date: Mon, 01 Apr 2013 15:17:50 -0700
Subject: [PATCH v3 6/7] USB: EHCI: make ehci-msm a separate driver
In-Reply-To: <201303301249.09239.arnd@arndb.de> (Arnd Bergmann's message of
 "Sat, 30 Mar 2013 12:49:09 +0000")
References: <Pine.LNX.4.44L0.1303291607090.1467-100000@iolanthe.rowland.org>
 <201303301249.09239.arnd@arndb.de>
Message-ID: <8yahajp3ng1.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Friday 29 March 2013, Alan Stern wrote:
>> On Thu, 28 Mar 2013, Arnd Bergmann wrote:
>
>> This patch is good.  However the ehci-msm driver itself is not.  While
>> checking through the code, I was struck by the fact that it never calls
>> usb_add_hcd() or usb_remove_hcd().  Obviously the driver cannot work
>> properly.
>> 
>> In addition, it stores the PHY pointer in a global variable.  
>> (ehci-atmel does much the same thing for its clocks.)  This means the
>> driver cannot be used on a system having more than one EHCI controller.  
>> Maybe this doesn't matter, though.
>> 
>> Maybe somebody would like to fix and test it...
>
> I'm not too surprised. The driver was added the last time that the MSM
> maintainers started a serious attempt to get a lot of their code mainlined,
> a little over two years ago. While there is some activity from Qualcomm
> in specific areas of the code every now and then, they literally have
> thousands of patches on top of the kernel that they use in actual
> products and I would not expect a mainline kernel to actually work on
> any recent Qualcomm hardware.

As far as this patch goes, you can have an
  Acked-by: David Brown <davidb@codeaurora.org>
for it.

I'm hoping things are going to get better as far as people working on
things.  EHCI is definitely an important one to get working (as is SD),
but we've got to get clocks and regulators working first.

David


-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
