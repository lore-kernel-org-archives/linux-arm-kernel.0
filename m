From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Tue, 24 May 2016 14:12:19 -0700
Subject: [PATCH v2 2/4] Documentation: Add documentation for APM X-Gene
 SoC PMU DTS binding
In-Reply-To: <CACgAJHyHEOe70pOG2yi-XUQS3BYdGmfYD-yTE0wFM9knDtHOiQ@mail.gmail.com>
References: <1460510547-17611-1-git-send-email-ttnguyen@apm.com>
 <1460510547-17611-3-git-send-email-ttnguyen@apm.com>
 <20160418170009.GA15338@rob-hp-laptop>
 <CACgAJHyBbO_LXwtfNVK1f=dY3v1Jfxwxq1dw98EZ0aYdhjPpAg@mail.gmail.com>
 <20160420113121.GE2514@arm.com>
 <20160502205648.GA7374@rob-hp-laptop>
 <CACgAJHyT31DuVNoyRQZVKjv=zM5Fc-EY0gy=y=pHHrBTT+1Xow@mail.gmail.com>
 <CACgAJHyHEOe70pOG2yi-XUQS3BYdGmfYD-yTE0wFM9knDtHOiQ@mail.gmail.com>
Message-ID: <CACgAJHz8bRb6E1xNFwhKpHDGxPhEsQ3J=H_u3woVLgzK0j==Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

It's been weeks.
I just want to ping again if you have any more comments on this patch set?

Thanks,
Tai

On Tue, May 10, 2016 at 4:43 PM, Tai Tri Nguyen <ttnguyen@apm.com> wrote:
> Hi Rob/Mark,
>
> Do you have any more comments, please?
>
> Thanks,
> Tai
>
> On Mon, May 2, 2016 at 2:46 PM, Tai Tri Nguyen <ttnguyen@apm.com> wrote:
>> Hi Rob,
>>
>> On Mon, May 2, 2016 at 1:56 PM, Rob Herring <robh@kernel.org> wrote:
>>> On Wed, Apr 20, 2016 at 12:31:22PM +0100, Will Deacon wrote:
>>>> On Mon, Apr 18, 2016 at 01:04:53PM -0700, Tai Tri Nguyen wrote:
>>>> > >> +Required properties for MCB subnode:
>>>> > >> +- compatible         : Shall be "apm,xgene-pmu-mcb".
>>>> > >> +- reg                        : First resource shall be the MCB PMU resource.
>>>> > >> +- index                      : Instance number of the MCB PMU.
>>>> > >> +
>>>> > >> +Required properties for MC subnode:
>>>> > >> +- compatible         : Shall be "apm,xgene-pmu-mc".
>>>> > >> +- reg                        : First resource shall be the MC PMU resource.
>>>> > >> +- index                      : Instance number of the MC PMU.
>>>> > >
>>>> > > Don't use indexes. You probably need phandles to the nodes these are
>>>> > > related to.
>>>> > >
>>>> > > How many variations of child nodes do you expect to have? 2, 10, 50? You
>>>> > > might want to just collapse all this down to a single node and put this
>>>> > > information in the driver if it is fixed for each SoC and there's only a
>>>> > > handful.
>>>> > >
>>>> >
>>>> > For each kind of PMU, for example memory controller PMU, I expect to
>>>> > have the number of instances up to 8.
>>>> > They are actually all independent PMU nodes and have their own CSR memory bases.
>>>> > The indexes are used for exposing the devices to perf user only. It
>>>> > doesn't have an impact on the programming model.
>>>> > Mark also had the same concern.
>>>>
>>>> Regardless, I'll need an ack from Rob or Mark before I can merge this.
>>>
>>> I still have a concern with this. Needing an index to expose to the user
>>> is generally not a valid reason. That's OS specific and therefore
>>> doesn't belong in DT.
>>>
>>> Rob
>>
>> I can use device name here. However, the perf event names will be
>> different between DT and ACPI which I want to avoid.
>> And the names don't look good at all.
>> Also, specifically for MC and MCB PMUs, the indexes are compared
>> against the active MC/MCB mask to find out whether they are populated
>> or not.
>> Without using the index property, I will also need a mapping function
>> of physical device addresses and their physical ids.
>>
>> Thanks,
>> --
>> Tai
>
>
>
> --
> Tai



-- 
Tai
