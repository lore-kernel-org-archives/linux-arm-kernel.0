From: N.Voss@weinmann.de (Voss, Nikolaus)
Date: Mon, 27 Aug 2012 15:22:17 +0200
Subject: [PATCH v11 4/4] G45 TWI: remove open drain setting for twi
 function gpios
In-Reply-To: <503B4AE6.4090107@atmel.com>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <6acdbd0f06cb9902efc510346564e10b07fa0b91.1345618760.git.n.voss@weinmann.de>
 <503B4AE6.4090107@atmel.com>
Message-ID: <EF2E73589CA71846A15D0B2CDF79505D090EC3D6E4@wm021.weinmann.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

ludovic.desroches wrote on Monday, August 27, 2012 12:25 PM:
> Le 11/08/2011 12:11 PM, Nikolaus Voss a ?crit :
>> The G45 datasheets explicitly states that setting the open drain property
>> on peripheral function gpios is not allowed. (How about other A91 chips?)
>
> Did you remove open drain because you had some issues or because you
> had  seen it into datasheet?
> 
> I tried with and without open drain. The behavior was the same. Looking
> to the G45 datasheet, I didn't see that the open drain property is not
> allowed on peripheral function gpios:
> 
> 'The Multi Drive can be selected whether the I/O line
> is controlled by the PIO controller or assigned to a peripheral function.'
> 
> The datasheet should have been updated or there is another place where
> it is mentioned that open drain property is not allowed in this case.

well, it didn't work on my G45. I found the following note in the
TWI chapter 31.6.1 of the G45 datasheet:
"The user must not program TWD and TWCK as open-drain.
It is already done by the hardware."

After removing the open-drain setting, it worked.

Regards,
Nikolaus
