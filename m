From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Dec 2017 13:00:07 -0600
Subject: DT dtc warnings
In-Reply-To: <20171214183642.GF2559@piout.net>
References: <CAL_JsqJKCzjx3zNigu_0T=Ku=_P2SQEjTx=uVbvr_QxJQR7kYg@mail.gmail.com>
 <20171214183642.GF2559@piout.net>
Message-ID: <CAL_JsqKqiyCb8s9cyM-LdZv+hyMjv2ZpfGZmyy9_+Wrd7-qF8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 14, 2017 at 12:36 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi Rob,
>
> On 14/12/2017 at 12:21:06 -0600, Rob Herring wrote:
>> Hi all,
>>
>> Below is a current list of ARM boards with more than 40 dtc warnings
>> when building with W=1. There's a treewide patch in flight to fix some
>> unit-address warnings[1], so those aren't included here. The list is
>> grouped by maintainer. AT91, Exynos, and Allwinner continue to be at
>> the top of the list and have been for some time (though having
>> multiple boards for an SoC can cause lots of duplicated warnings).
>>
>> Please help fix these. More checks are being added[2].
>>
>
> For the at91 ones, IIRC, they are coming from the clock binding and we
> will have to break the ABI to fix it. This is not something we wanted to
> do before 4.14 but it will happen at some point.

Looks like they are just missing unit-address. How does adding a
unit-address break the ABI? Though, aren't you planning to change from
a node per clock to clock controller node(s)? If so, then fixing when
doing that is fine.

Rob
