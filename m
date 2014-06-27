From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Jun 2014 09:50:46 +0200
Subject: [PATCH v2 1/2] Documentation: Document Hisilicon hix5hd2 sata PHY
In-Reply-To: <53ACE6EE.4050300@linaro.org>
References: <1403687648-29082-1-git-send-email-zhangfei.gao@linaro.org>
 <4989178.vejv39dnj8@wuerfel> <53ACE6EE.4050300@linaro.org>
Message-ID: <11262017.C011KreL6u@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 June 2014 11:37:18 zhangfei wrote:
> >
> 
> Sorry for the confusion.
> 
> The phy is rather an analog controller, without standard register.
> Instead, the phy interface is just some pin / analog interface.
> The register is in fact hix5hd2 register, controls all the analog 
> output, including reset, power, speed, para tunning.

Ok, thanks for the explanation.

> Even the same phy is used in other soc, they can not share this driver, 
> since the connection must be different, as well as internal soc register 
> layout.
> Only if the same controller & phy are reused in other hisilicon soc, 
> this driver can be shared.
> 
> Since what we control is hix5hd2 controller itself, so it may not 
> suitable to put snps here.

Makes sense.

> And about hix5hd2 name: x is not wildcard.
> 
> Currently hix5hd2 is series of hi3716c v200, hi3719c v100, hi3718c v100.
> They are same soc, except minus pin assembles different.
> 
> However, not all hi37x is in this series, for example hi3716c v100 is a 
> different soc.
> 
> In the future hi3719m, hi3718m may also plan to add to hix5hd2 series.
> The difference will be different cpu core number, different gpu core 
> number. Also use different ethernet controller.

Ah, I think you explained this before, sorry for misremembering it.
 
> So we may still keep "hisilicon,hix5hd2-sata-phy" unchanged.
> What do you think?

Yes, please keep this string, it's good.

Thanks for your patience,

	Arnd
