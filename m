From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 17 Mar 2014 11:01:49 +0100
Subject: [PATCH] ARM: mach-ux500|nomadik|u300: Align to common DT bindings
 for mmci
In-Reply-To: <CACRpkdZzObyJQmbAvovcor9NXeVnhEFO82jtxLZOdm48TPnudQ@mail.gmail.com>
References: <1394713963-18300-1-git-send-email-ulf.hansson@linaro.org>
 <20140313174703.GO21483@n2100.arm.linux.org.uk>
 <CAPDyKFrw092mbirDBffF6TraUoXDLh5movp_sf9PYERG88P-Qw@mail.gmail.com>
 <CACRpkdZzObyJQmbAvovcor9NXeVnhEFO82jtxLZOdm48TPnudQ@mail.gmail.com>
Message-ID: <CAPDyKFpJDKXK7siVMnB5umv6PnYAyNmto1yq9unxDaD9BP=oBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 March 2014 11:58, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Mar 14, 2014 at 8:27 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 13 March 2014 18:47, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>>> On Thu, Mar 13, 2014 at 01:32:43PM +0100, Ulf Hansson wrote:
>>>> As the first step in preparing the mmci driver for converting to the
>>>> mmc_of_parse API, let's align to the common names of DT bindings for
>>>> the mmc/sd highspeed modes.
>>>
>>> NAK.  These bindings have been documented as being there since March
>>> 14th 2012, and therefore need to be supported for ever by the driver.
>>> You can _augment_ the bindings with the generic ones, and change the
>>> DT files, but you can't remove the parsing of the old property names.
>>
>> I was kind of expecting this response. :-)
>>
>> So, since we made a mistake about adding these DT bindings we are now
>> unable to remove them, is there really no way back?
>>
>> In this particular case, I am confident that it should be safe to
>> remove them, but I guess this is more matter of principle, right?
>
> I can guarantee that there are no deployed U300, Nomadik or
> Ux500 systems out there with DTBs deployed in them, and
> for certain no products. At one point that was the criterion...
> All setups actually use the appended device tree.

It sure seems like it's safe to remove them.

If you decide to accept the patch, could we queue it through ARM SOC
with your help Linus? Maybe even for 3.15 as the sooner the better!?

>
> In worst case I guess mmc-cap-sd-highspeed and
> mmc-cap-mmc-highspeed could be put as aliases into the
> generic parser?

That's an option - and maybe mark them as deprecated. Still I would
prefer if we could remove them instead.

Kind regards
Ulf Hansson

>
> Yours,
> Linus Walleij
