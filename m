From: davidb@codeaurora.org (David Brown)
Date: Tue, 22 Feb 2011 16:17:20 -0800
Subject: [PATCH] msm: add single-wire serial bus interface (SSBI) driver
In-Reply-To: <1298419839.17118.5.camel@m0nster> (Daniel Walker's message of
	"Tue, 22 Feb 2011 16:10:39 -0800")
References: <1297989299-27320-1-git-send-email-kheitke@codeaurora.org>
	<1297989432.9680.50.camel@c-dwalke-linux.qualcomm.com>
	<4D5DC289.1090004@codeaurora.org>
	<1298054771.17758.1.camel@c-dwalke-linux.qualcomm.com>
	<AANLkTi=0Pxg09x8DdVDVy9Ur7r1dgB+4LM3q0hM4_8Rg@mail.gmail.com>
	<1298419839.17118.5.camel@m0nster>
Message-ID: <8ya62sbli3z.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22 2011, Daniel Walker wrote:

> On Tue, 2011-02-22 at 12:47 -0800, Dima Zavin wrote:
>
>> What is the problem leaving it under arch/arm/mach-msm?
>
> Because it's a driver.

There are a lot of other drivers currently under various arch
subsystems.  I'm not sure if a driver that is specific to only one arch
has a strong reason to be elsewhere in the kernel.  If there was a
possibility of there being other devices that used SSBI, it might make
sense to put it elsewhere.  But, as far as I know, this device is only
found on MSM chips.

It seems kind of unusual to create an entirely new directory under
drivers to hold what will only ever be a single driver.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
