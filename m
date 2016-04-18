From: ttnguyen@apm.com (Tai Tri Nguyen)
Date: Mon, 18 Apr 2016 13:04:53 -0700
Subject: [PATCH v2 2/4] Documentation: Add documentation for APM X-Gene
 SoC PMU DTS binding
In-Reply-To: <20160418170009.GA15338@rob-hp-laptop>
References: <1460510547-17611-1-git-send-email-ttnguyen@apm.com>
 <1460510547-17611-3-git-send-email-ttnguyen@apm.com>
 <20160418170009.GA15338@rob-hp-laptop>
Message-ID: <CACgAJHyBbO_LXwtfNVK1f=dY3v1Jfxwxq1dw98EZ0aYdhjPpAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

[...]

>> +Required properties for MCB subnode:
>> +- compatible         : Shall be "apm,xgene-pmu-mcb".
>> +- reg                        : First resource shall be the MCB PMU resource.
>> +- index                      : Instance number of the MCB PMU.
>> +
>> +Required properties for MC subnode:
>> +- compatible         : Shall be "apm,xgene-pmu-mc".
>> +- reg                        : First resource shall be the MC PMU resource.
>> +- index                      : Instance number of the MC PMU.
>
> Don't use indexes. You probably need phandles to the nodes these are
> related to.
>
> How many variations of child nodes do you expect to have? 2, 10, 50? You
> might want to just collapse all this down to a single node and put this
> information in the driver if it is fixed for each SoC and there's only a
> handful.
>

For each kind of PMU, for example memory controller PMU, I expect to
have the number of instances up to 8.
They are actually all independent PMU nodes and have their own CSR memory bases.
The indexes are used for exposing the devices to perf user only. It
doesn't have an impact on the programming model.
Mark also had the same concern.

Thanks,
-- 
Tai
