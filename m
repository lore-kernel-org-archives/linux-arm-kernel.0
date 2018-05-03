From: dianders@chromium.org (Doug Anderson)
Date: Thu, 3 May 2018 08:01:27 -0700
Subject: [PATCH v2 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <db8970ea-05f4-e7c0-52fa-070c7a6b8d2e@codeaurora.org>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=UDUKg58xe+3C5QUbFwFkO8d3c_tzxmfPDzdv1KXZ3W9g@mail.gmail.com>
 <db8970ea-05f4-e7c0-52fa-070c7a6b8d2e@codeaurora.org>
Message-ID: <CAD=FV=UC4CqOut0GoJ-heqdZ9NTHzzgBpVWy3XAMFax26HoZmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 2, 2018 at 5:13 PM, David Collins <collinsd@codeaurora.org> wrote:
> On 05/02/2018 09:37 AM, Doug Anderson wrote:
>> On Fri, Apr 13, 2018 at 7:50 PM, David Collins <collinsd@codeaurora.org> wrote:
>>> +- vdd_l26-supply
>>> +- vdd_lvs1_lvs2-supply
>>> +- vdd_lvs1_lvs2-supply
>>> +       Usage:      optional (PM8998 only)
>>> +       Value type: <phandle>
>>> +       Definition: phandle of the parent supply regulator of one or more of the
>>> +                   regulators for this PMIC.
>>
>> One small additional nit here is that "vdd_lvs1_lvs2-supply" is listed twice.
>
> I'll remove the duplicate.
>
>
>> Also on the schematics (and in the PM8998 datasheet) I have this is
>> "VIN_LVS_1_2".  It seems like you should be consistent here and call
>> this "vin-lvs-1-2-supply".
>
> I was trying to keep the naming consistent within device tree binding
> documentation for LVS vs LDO and SMPS (e.g. 'vdd' vs 'vin' prefix).  I
> suppose that I can change this to match the hardware documentation pin
> name.  I can also change '_' to '-' in the supply names if that is preferred.

I'd rather it match the docs.  I personally have no idea for why the
writer of the docs used "vdd" vs. "vin", but even if they had no good
reason matching the docs makes this searchable.

As far as the "_" to "-", Rob asked for that earlier in this thread
and you says "I will change this on the next patch set."  In general
the desire to convert "_" to "-" makes this less searchable (since the
docs use "_"), but that's the way device tree guys want it so so c'est
la vie.  Luckily it's easily to mentally change the "-"s back to "_"s
when searching...

-Doug
