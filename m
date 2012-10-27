From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Sat, 27 Oct 2012 18:18:51 +0200
Subject: [PATCH 1/4] mfd: ab8500: add devicetree support for fuelgauge
In-Reply-To: <CAB4BAkuPE6eSr2+LWTaV9trOnFk-_yt-+x8f6zpum=Ws1UvmmA@mail.gmail.com>
References: <1351146654-9110-1-git-send-email-rajanikanth.hv@stericsson.com>
 <1351146654-9110-2-git-send-email-rajanikanth.hv@stericsson.com>
 <508BF8A8.9090206@gmail.com>
 <CAB4BAkuPE6eSr2+LWTaV9trOnFk-_yt-+x8f6zpum=Ws1UvmmA@mail.gmail.com>
Message-ID: <508C096B.6060902@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2012 06:00 PM, Rajanikanth HV wrote:
> On 27 October 2012 20:37, Francesco Lavra <francescolavra.fl@gmail.com> wrote:
>> On 10/25/2012 08:30 AM, Rajanikanth H.V wrote:
>>> From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>
>>> +     bat_tech = of_get_property(np_bat_supply,
>>> +                     "stericsson,battery-type", NULL);
>>> +     if (!bat_tech)
>>> +             dev_warn(dev, "missing property battery-name/type\n");
>>> +
>>> +     if (strncmp(bat_tech, "LION", 4) == 0) {
>>
>> What if bat_tech is NULL?
> It will be UNKNOWN

I wanted to draw your attention to the fact that if bat_tech is NULL you
are passing a NULL pointer to strncmp(), which is not good.
So you should assign a default value to bat_tech in case the battery
type property is not found in the DT, as below:

if (!bat_tech) {
	dev_warn(dev, "missing property battery-name/type\n");
	bat_tech = "UNKNOWN";
}

--
Francesco
