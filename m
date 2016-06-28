From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 28 Jun 2016 14:59:19 -0700
Subject: [PATCH] extcon: Add support for qcom SPMI PMIC USB id detection
 hardware
In-Reply-To: <CAGTfZH3ZhZ2gQcOSuAByZWD59E3Bro1aayr2JsM2W+mYa2LQTQ@mail.gmail.com>
References: <20160626055647.18898-1-stephen.boyd@linaro.org>
 <CAGTfZH3ireJWo5-Jd5SEiSy-WMTsw43pweruOqwSesAZqagvtg@mail.gmail.com>
 <146705470025.30684.13257433085055355379@sboyd-linaro>
 <CAGTfZH3ZhZ2gQcOSuAByZWD59E3Bro1aayr2JsM2W+mYa2LQTQ@mail.gmail.com>
Message-ID: <146715115921.31418.2315766296233007937@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Chanwoo Choi (2016-06-28 05:06:48)
> 2016-06-28 4:11 GMT+09:00 Stephen Boyd <stephen.boyd@linaro.org>:
> > Quoting Chanwoo Choi (2016-06-26 04:20:43)
> >> 2016-06-26 14:56 GMT+09:00 Stephen Boyd <stephen.boyd@linaro.org>:
> >> > +PROPERTIES
> >> > +
> >> > +- compatible:
> >> > +    Usage: required
> >> > +    Value type: <string>
> >> > +    Definition: Should contain "qcom,pm8941-misc";
> >> > +
> >> > +- reg:
> >> > +    Usage: required
> >> > +    Value type: <u32>
> >> > +    Definition: Should contain the offset to the misc address space
> >>
> >> 'reg' property is used on extcon-qcom-spmi-misc.c?
> >> I think that you don't need to include this property.
> >
> > No it isn't used in the driver right now, but there is a register offset
> > for this module and there are registers that can be read/written in this
> > module. I'd like to keep it as required so we can easily read the
> > registers in the future if needed.
> 
> OK.
> But, If you want to remain the reg property, you should add the code to get
> the register offset by using OF functions. This patch don't include the OF
> function to handle it.
> 

Sorry I don't follow the argument. I've put the reg property here for
future proofing so that the binding doesn't have to change in backwards
incompatible ways in the future if we do need to get the property later.
