From: javier.martin@vista-silicon.com (javier Martin)
Date: Fri, 27 Jul 2012 11:33:13 +0200
Subject: Sharing resources between several drivers.
In-Reply-To: <20120727111958.4409033f@skate>
References: <CACKLOr2enmsVqQnJ8JZJJd3z3gGKDKwj74PnWKEk6SwSN=ZoJw@mail.gmail.com>
 <20120727111958.4409033f@skate>
Message-ID: <CACKLOr3KAKoCw4gbegQk8BbYTAaArEnWweUZ51W5ddv5MepLcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 July 2012 11:19, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Le Fri, 27 Jul 2012 09:59:21 +0200,
> javier Martin <javier.martin@vista-silicon.com> a ?crit :
>
>> Hi,
>> we are trying to support pinctrl for i.MX21, i.MX1 and i.MX27.
>>
>> In these chips, gpio and pinctrl use the same HW memory area
>> registers. This means that we have to request the same memory area
>> from two different drivers (gpio and pinctrl) but we don't know how to
>> do that.
>>
>> A similar example available is mxs, but it only works with device
>> tree, so this problem is avoided.  However, some of these chips
>> (i.MX21, i.MX1...) don't support device tree yet, so we need to
>> provide backwards compatibility.
>>
>> What is the right way to request the same memory region from two
>> different drivers? Moreover, how can we guarantee that there won't be
>> any conflicts when accessing these shared resources?
>
> I would say there is no right way. If the pinctrl/gpio registers are
> really intermixed and belong to the same region, then there should be
> only one driver that requests this region and that implements both the
> pinctrl and gpio features.
>
> See the drivers/pinctrl/pinctrl-coh901.c driver for example. It
> implements both the pinctrl and the gpio logic.

Thank you, that was very useful.

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
