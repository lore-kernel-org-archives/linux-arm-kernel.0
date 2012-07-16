From: cjb@laptop.org (Chris Ball)
Date: Mon, 16 Jul 2012 16:04:25 -0400
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <CACRpkdaMB-n7XYcxE8QtAm-WrGc2DR0krfTjQZCbvOL1HYep1Q@mail.gmail.com>
 (Linus Walleij's message of "Mon, 16 Jul 2012 21:45:29 +0200")
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
 <20120712131231.GH2194@pengutronix.de>
 <CACRpkdboeF_G=sTPeSyuZ6KGLCmGSKx_NS=6Rim6HkR2f9=AAQ@mail.gmail.com>
 <20120716101706.GB17435@pengutronix.de>
 <CACRpkdY626iYATorphAvg7cQxD2ufysBvXdt3Z644zEuW0wS=w@mail.gmail.com>
 <20120716123550.GE17435@pengutronix.de>
 <CACRpkdaMB-n7XYcxE8QtAm-WrGc2DR0krfTjQZCbvOL1HYep1Q@mail.gmail.com>
Message-ID: <874np7jwvq.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 16 2012, Linus Walleij wrote:
>> Uhm, I seem to have missed that bindings are deemed more "flexible" as
>> long as they are coupled to in-kernel dts files? Is that discussed
>> somewhere? I do wonder about it...
>
> Well patches like this are sent out but not commented on from
> the perspective of binding stability. So of course, they get merged.
>
> Have a look at this commit:
>
> commit 7f217794ffa72f208a250b79ab0b7ea3de19677f
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Sun May 13 00:14:24 2012 -0400
>
>     mmc: dt: Consolidate DT bindings
>
> This is deleting custom properties from DTS files without
> adding any code to fallback-support them on old device trees.

I agree with your point, but just as an FYI: this patch did involve
a conversation about binding stability, and left some attributes
(e.g. ti,non-removable) purposefully alone (and different to the
new generic MMC bindings) to preserve backwards compatibility:

http://article.gmane.org/gmane.linux.kernel.samsung-soc/10409

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
