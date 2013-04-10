From: tony@atomide.com (Tony Lindgren)
Date: Wed, 10 Apr 2013 13:34:09 -0700
Subject: Query on pinctrl usage for DT nodes
In-Reply-To: <5165A22B.4070200@wwwdotorg.org>
References: <CA+V-a8uiPwsAD--OHFAE=i2ed+-wbXm4p2deZXr92+Zv6GDS1w@mail.gmail.com>
 <515C5C76.3080009@wwwdotorg.org>
 <CA+V-a8t3wtP77DdeUoQHKMjAuWmV+ude+1J3UjJmMTqobgStjA@mail.gmail.com>
 <5162FD4A.1030909@wwwdotorg.org>
 <CA+V-a8vwdCkyMqiynj5BodXbjwJ=e4qNb-29FhLweqbjc7DBQA@mail.gmail.com>
 <5165A22B.4070200@wwwdotorg.org>
Message-ID: <20130410203408.GP10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [130410 10:37]:
> On 04/10/2013 02:12 AM, Prabhakar Lad wrote:
> ...
> > Following is the proposed fix/hack let me know if its OK.
> > 
> > Regards,
> > --Prabhakar
> > 
> > ->>>>>>>>>>>>>>>>>>>
> > 
> > diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
> > index ee72f1f..78fb42d 100644
> > --- a/drivers/pinctrl/core.h
> > +++ b/drivers/pinctrl/core.h
> > @@ -46,6 +46,7 @@ struct pinctrl_dev {
> >         struct pinctrl *p;
> >         struct pinctrl_state *hog_default;
> >         struct pinctrl_state *hog_sleep;
> > +       bool bits_per_mux;
> 
> This clearly isn't correct; any change to solve this problem should only
> touch the internals of the pinctrl-single driver, not the pinctrl core.

Yeah how about just change the pintctrl-single,bits register
naming to be register + bit?  Something like 0xdeadbeef.0 and
0xdeadbeef.1 and so on.

Regards,

Tony
