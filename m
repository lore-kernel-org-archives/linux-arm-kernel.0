From: jm@lentin.co.uk (Jamie Lentin)
Date: Mon, 12 Aug 2013 18:03:42 +0100 (BST)
Subject: [PATCH 1/2] Convert power recovery pin to a fixed regulator
In-Reply-To: <20130812165139.GM25111@titan.lakedaemon.net>
References: <1376231210-6484-1-git-send-email-jm@lentin.co.uk>
 <1376231210-6484-2-git-send-email-jm@lentin.co.uk>
 <20130811182444.GG6427@sirena.org.uk>
 <20130812165139.GM25111@titan.lakedaemon.net>
Message-ID: <alpine.DEB.2.00.1308121754340.8256@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Aug 2013, Jason Cooper wrote:

> On Sun, Aug 11, 2013 at 07:24:44PM +0100, Mark Brown wrote:
>> On Sun, Aug 11, 2013 at 03:26:49PM +0100, Jamie Lentin wrote:
>>> dnskw_gpio_register() is broken, and probably has been for a while,
>>> since dnskw_init() is called too early to register GPIOs. Instead use a
>>> fixed regulator to turn the pin high, which knows to defer the
>>> registration until later.
>>
>> So, this is really abuse of the regulator API since it knows how to set
>> a GPIO.  Perhaps the reset controller might be a better fit, or pinctrl
>> defaults?
>
> I vote for the reset controller.

Okay, will rummage and come back with a separate patch. Thanks for your 
suggestions!

> Jamie, I'm taking the deletion part of both of these patches since it
> didn't work any way and it's the last holdout of DT platform code in
> kirkwood.
>
> Once you get the DT node nailed down for the reset pin, just submit it
> by itself.

Please do, the code isn't in any way useful.

> thx,
>
> Jason.
>

-- 
Jamie Lentin
