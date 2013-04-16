From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Apr 2013 14:32:33 -0700
Subject: Query on pinctrl usage for DT nodes
In-Reply-To: <516BB99F.2080502@ti.com>
References: <CA+V-a8uiPwsAD--OHFAE=i2ed+-wbXm4p2deZXr92+Zv6GDS1w@mail.gmail.com>
 <515C5C76.3080009@wwwdotorg.org>
 <CA+V-a8t3wtP77DdeUoQHKMjAuWmV+ude+1J3UjJmMTqobgStjA@mail.gmail.com>
 <5162FD4A.1030909@wwwdotorg.org>
 <CA+V-a8vwdCkyMqiynj5BodXbjwJ=e4qNb-29FhLweqbjc7DBQA@mail.gmail.com>
 <5165A22B.4070200@wwwdotorg.org>
 <20130410203408.GP10155@atomide.com> <516BB99F.2080502@ti.com>
Message-ID: <20130416213232.GU10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130415 01:30]:
> On 04/10/2013 10:34 PM, Tony Lindgren wrote:
> > Yeah how about just change the pintctrl-single,bits register
> > naming to be register + bit?  Something like 0xdeadbeef.0 and
> > 0xdeadbeef.1 and so on.
> 
> Something like this might work I think. It is going to be a bit tricky IMHO
> since we might need span out new 'register' every time a device requests for a
> new pinctrl-single,bits for already used register in the
> pinctrl-single,bit-per-mux area. In this way we still can make sure that
> certain bit are only used by a single driver.

OK. If it's one bit per mux type register we should be able to create
the right amount of entries based on the submask in pinctrs-single,bit?

Regards,

Tony
