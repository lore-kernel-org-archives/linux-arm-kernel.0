From: t.stanislaws@samsung.com (Tomasz Stanislawski)
Date: Mon, 05 May 2014 16:15:03 +0200
Subject: [PATCH 0/2] Add support for sii9234 chip
In-Reply-To: <20140503231726.GA20212@kroah.com>
References: <1397216910-15904-1-git-send-email-t.stanislaws@samsung.com>
 <20140503231726.GA20212@kroah.com>
Message-ID: <53679CE7.3070202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2014 01:17 AM, Greg KH wrote:
> On Fri, Apr 11, 2014 at 01:48:28PM +0200, Tomasz Stanislawski wrote:
>> Hi everyone,
>> This patchset adds support for sii9234 HD Mobile Link Bridge.  The chip is used
>> to convert HDMI signal into MHL.  The driver enables HDMI output on Trats and
>> Trats2 boards.
>>
>> The code is based on the driver [1] developed by:
>>        Adam Hampson <ahampson@sta.samsung.com>
>>        Erik Gilling <konkers@android.com>
>> with additional contributions from:
>>        Shankar Bandal <shankar.b@samsung.com>
>>        Dharam Kumar <dharam.kr@samsung.com>
>>
>> The drivers architecture was greatly simplified and transformed into a form
>> accepted (hopefully) by opensource community.  The main differences from
>> original code are:
>> * using single I2C client instead of 4 subclients
>> * remove all logic non-related to establishing HDMI link
>> * simplify error handling
>> * rewrite state machine in interrupt handler
>> * wakeup and discovery triggered by an extcon event
>> * integrate with Device Tree
>>
>> For now, the driver is added to drivers/misc/ directory because it has neigher
>> userspace nor kernel interface.  The chip is capable of receiving and
>> processing CEC events, so the driver may export an input device in /dev/ in the
>> future.  However CEC could be also handled by HDMI driver.
>>
>> I kindly ask for suggestions about the best location for this driver.
> 
> It really is an extcon driver, so why not put it in drivers/extcon?  And
> that might solve any build issues you have if you don't select extcon in
> your .config file and try to build this code :)
> 
> thanks,

Hi Greg,
Thank you for your comments.

As I understand, drivers/extcon contains only extcon providers.
This driver is an extcon client, so mentioned location may not be adequate.

I am surprised that there are no comments about this driver.
Sii9234 chip is present on many exynos based boards/phones
and HDMI subsystem will not work without this code.

Regards,
Tomasz Stanislawski

> 
> greg k-h
> 
