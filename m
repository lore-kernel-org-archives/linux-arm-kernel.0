From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Oct 2015 15:36:24 +0100
Subject: [PATCH 07/11] pinctrl: use ngpios propety from DT
In-Reply-To: <0C803592FC378B4E83922050AB46442A2AD742F0@SJEXCHMB10.corp.ad.broadcom.com>
References: <1445233398-27129-1-git-send-email-pramodku@broadcom.com>
 <1445233398-27129-8-git-send-email-pramodku@broadcom.com>
 <CACRpkdY1GDs6ypqCiY3iiv3DkfnHchnY+bWPoCqU=_sgn9f5vQ@mail.gmail.com>
 <0C803592FC378B4E83922050AB46442A2AD742F0@SJEXCHMB10.corp.ad.broadcom.com>
Message-ID: <CACRpkdb3FT0K+atNOTXL_e8Fs7Nm0VDLe0RPiiBKK=8o=MHqKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 12:52 PM, Pramod Kumar <pramodku@broadcom.com> wrote:

> I discussed with ASIC team regarding this iProc GPIO block. They use a library to create the GPIOs block where "total number of GPIO pins( let say N) in GPIO block" is used as an parameter.
> Library uses a construct for *a* GPIO pin. This gets instantiated N times to create a complete GPIO block with N pins.
>
> All iProc based SoCs uses this library. So I'm not sure whether attaching "total number of GPIOs pins" to compatible-string make sense in this case.
> I personally feel that passing this number from the DT makes more sense here. Any iProc based future as well as current SoCs would be able to use this driver without any change.
>
> Please advise us in this case.

Hm! You make a good case.

But this contradicts the traditional use of ngpios.

But on the other hand:
git grep ngpio Documentation/devicetree/bindings/gpio/

Gives at hand that the use of ngpio[s] is a complete mess.

:(

I will think about patching the standard bindings to fix this mess
and include your case. Give me some time.

Yours,
Linus Walleij
