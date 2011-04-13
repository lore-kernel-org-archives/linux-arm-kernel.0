From: arend@broadcom.com (Arend van Spriel)
Date: Wed, 13 Apr 2011 10:16:37 +0200
Subject: [RFC][PATCH] axi: add AXI bus driver
In-Reply-To: <BANLkTim8dmTL-BVK3fcWHNBU9Eyz1k_T+Q@mail.gmail.com>
References: <1302566227-23788-1-git-send-email-zajec5@gmail.com>
	<20110412133633.GR15130@legolas.emea.dhcp.ti.com>
	<1302634039.14216.10.camel@dev.znau.edu.ua>
	<BANLkTi=0sM2+nPYyd09G=Uy9rcEvaFErnA@mail.gmail.com>
	<1302635550.14216.21.camel@dev.znau.edu.ua>
	<BANLkTi=8mB9ZDTjF4yds6mkx+PmM+B_6Cg@mail.gmail.com>
	<4DA4AC4B.90409@hauke-m.de>
	<BANLkTiknRYWaDM1ThAxgXcdGqK8jeFaBPA@mail.gmail.com>
	<BANLkTikqKtJuDS17mfFvxzMoXuBtJvCgTA@mail.gmail.com>
	<1302640546.14216.65.camel@dev.znau.edu.ua>
	<BANLkTim8dmTL-BVK3fcWHNBU9Eyz1k_T+Q@mail.gmail.com>
Message-ID: <op.vtvalzu33ri7v4@arend-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Apr 2011 22:44:01 +0200, Rafa? Mi?ecki <zajec5@gmail.com> wrote:

> 2011/4/12 George Kashperko <george@znau.edu.ua>:
>>> 2011/4/12 Rafa? Mi?ecki <zajec5@gmail.com>:
>>> That way I see really low (or not at all) relation between out
>>> (not)Broadcom bus and present AMBA bus.
>>>
>> Agree.
>
> Ehh, sounds like one more renaming to functions, defines, prefixes.
>
> Let's wait for Arend comments, he was the one voting for  
> not-bcm-specific name.
>

Hi Rafa?,

Still think its better to stick with a generic name even if currently you  
only come across this in Broadcom chips right now. I do agree that the  
term 'axi' is implying something else than what this bus driver is  
providing. The name 'axi-dmp' I gave earlier may be more to the point.

I also looked at the amba driver after receiving comments on the brcmaxi  
library module (this is what Hauke Mehrtens referred to) and came to  
similar conclusion as you did. It does however support PM properly so you  
may want to get inspiration in that area. I also noticed a reference to  
AMBA term APB which is a different bus in the AMBA family. AXI was  
introduced later as higher performance bus (in AMBA rev3 if I remember  
correctly).

Gr. AvS
-- 
"The world is indeed comic, but the joke is on mankind." ? H.P. Lovecraft
