From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2011 14:21:51 +0200
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
Message-ID: <BANLkTi=W7jaVtW1FThvG_ca57q+yDz1kzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/19 Ben Nizette <bn@niasdigital.com>:
> On 18/04/2011, at 10:26 PM, Alan Cox wrote:
>
>> The logical extension to that is to delete the gpio layer because the
>> board code can do it ?
>
> Well anything that is done once at startup, yes,

This patch is about biasing and drive modes. We need to alter
these at runtime (from board code, indeed) due to the fact that
when you go to sleep e.g. floating a pin yeilds better power
characteristics.

Linus Walleij
