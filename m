From: robherring2@gmail.com (Rob Herring)
Date: Wed, 21 Nov 2012 09:07:59 -0600
Subject: [PATCH 15/16] irqchip: vic: mark vic_of_init() as static
In-Reply-To: <20121121154641.718c7b69@skate>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353448867-15008-16-git-send-email-thomas.petazzoni@free-electrons.com>
 <CACRpkdazuvjXuuNP9TrsYsPQWMc=VV_-nu0oNWFPs+GzLmmw2g@mail.gmail.com>
 <20121121135357.5c963404@skate>
 <CACRpkdYU+tt=_xqVjoBnca-V8psRmZhU+UWUm-6i777vP5BChA@mail.gmail.com>
 <20121121154641.718c7b69@skate>
Message-ID: <50ACEE4F.3030409@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2012 08:46 AM, Thomas Petazzoni wrote:
> Linus,
> 
> On Wed, 21 Nov 2012 15:40:02 +0100, Linus Walleij wrote:
>> On Wed, Nov 21, 2012 at 1:53 PM, Thomas Petazzoni
>> <thomas.petazzoni@free-electrons.com> wrote:
>>> On Wed, 21 Nov 2012 13:40:57 +0100, Linus Walleij wrote:
>>
>>>> It may be that I have missed some patches, but are really all VIC
>>>> users converted in this patch series?
>>>
>>> In this patch series, I'm making vic_of_init() static. vic_init() used
>>> by non-DT platforms is kept as is, with no change, so I'm not sure why
>>> you're worried about vic_init() being a problem.
>>
>> Probably because I didn't parse the _of_ part :-/
>>
>> Sorry about the fuzz!
> 
> No problem :)
> 
>> But the idea is to use the same convenient mechanism for
>> the non-DT platforms later, so we get rid of all the incldue
>> headers I guess?
> 
> Yes. I personally haven't yet thought of this part of the problem, but
> I think Rob has a plan, and if not, we can certainly think of one
> without too much problems.

While we can trim down the headers, I don't think we will get rid of
them in all cases. My only plan was everything gets converted to DT.
Then we can remove gic_init, gic_cascade_irq, and vic_init.

Rob
