From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Apr 2017 19:58:21 +0800
Subject: [linux-sunxi] [PATCH v3 09/12] mfd: axp20x: add axp20x-regulator
 cell for AXP803
In-Reply-To: <6D57E4F4-DD87-400F-A21B-85778434AADC@aosc.io>
References: <20170417115747.7300-1-icenowy@aosc.io>
 <20170417115747.7300-10-icenowy@aosc.io>
 <CAGb2v648fhGSjWoVYRxU+_kF5fhbnhmY2mQG16ORtBHf7pGx5w@mail.gmail.com>
 <6D57E4F4-DD87-400F-A21B-85778434AADC@aosc.io>
Message-ID: <CAGb2v67=iHeTRSzOa-hH+wcQuRAPsGk=sPAqead_Au6ekW_P5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 6:55 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> ? 2017?4?18? GMT+08:00 ??6:38:09, Chen-Yu Tsai <wens@csie.org> ??:
>>On Mon, Apr 17, 2017 at 7:57 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>>> As axp20x-regulator now supports AXP803, add a cell for it.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>> Changes in v3:
>>> - Make the new cell one-liner.
>>>
>>>  drivers/mfd/axp20x.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>>> index 1dc6235778eb..431b7f118606 100644
>>> --- a/drivers/mfd/axp20x.c
>>> +++ b/drivers/mfd/axp20x.c
>>> @@ -848,7 +848,8 @@ static struct mfd_cell axp803_cells[] = {
>>>                 .name                   = "axp20x-pek",
>>>                 .num_resources          =
>>ARRAY_SIZE(axp803_pek_resources),
>>>                 .resources              = axp803_pek_resources,
>>> -       }
>>> +       },
>>> +       {       .name                   = "axp20x-regulator" }
>>
>>It's best to have a trailing comma, so we don't have to change the line
>>again when we add more cells, like you just did with the previous line.
>
> Should I also add it in previous mfd patch? (and remove the addition of the comma in this patch)

Since Lee already said he merged it, I suggest you keep it the way it is,
unless he says otherwise. Or your new patches might not apply correctly,
and you waste time doing one more round.

Maintainers don't always push the latest branches, for a number of reasons.
Sometimes it's because the merge window is closed, and you're not supposed
to put anything that's not for the next release into -next. Other times it
might because they are still working through their backlog. Or they may
have just forgotten.

ChenYu
