From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Thu, 03 Dec 2009 09:03:27 +0100
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
In-Reply-To: <4B16D861.6090307@warmcat.com>
References: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>	
	<37367b3a0912021058j2801df5l2c937ac339bc5f6b@mail.gmail.com>	
	<4B16C185.80905@warmcat.com>
	<37367b3a0912021225l67455ca2q2c7d0464279f446e@mail.gmail.com>
	<4B16D861.6090307@warmcat.com>
Message-ID: <4B1770CF.5090401@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Andy Green wrote:
> On 12/02/09 20:25, Somebody in the thread at some point said:
> 
>>> What did you do with your chip select line on the ULPI PHY?
>> I turn this line (CS_N) low before initializing ISP1504.
> 
> It's more a question about what that input on the PHY chip sees during 
> powerup / reset... it needs to be nicely and definitely high the whole 
> time so it will ignore what happens then.  Is it pulled up, or just 
> connected to the iMX GPIO?  iMX GPIO alone may not be enough.  They 
> mostly default to 100K pullup but even that may not be enabled early in 
> the powerup action.
> 
> A 10K to your IO voltage rail on CS_N solved it for the LiteKIT and on 
> the boards we have made.
> 

I just wanted to point out that we also have a 10K pull-up on the CS_N 
on our boards, it helps a lot.

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne
