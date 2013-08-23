From: zonque@gmail.com (Daniel Mack)
Date: Fri, 23 Aug 2013 19:24:38 +0200
Subject: [PATCH v4 3/5] net: ethernet: cpsw: introduce ti,am3352-cpsw
 compatible string
In-Reply-To: <521799A3.7080706@ti.com>
References: <1377267365-24057-1-git-send-email-zonque@gmail.com>
 <1377267365-24057-4-git-send-email-zonque@gmail.com>
 <52177052.1030308@ti.com> <52178E20.5040404@gmail.com>
 <52179448.1020906@ti.com> <5217974B.5090503@ti.com> <521799A3.7080706@ti.com>
Message-ID: <52179AD6.8090406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.08.2013 19:19, Santosh Shilimkar wrote:
> On Friday 23 August 2013 01:09 PM, Sekhar Nori wrote:
>> On 8/23/2013 10:26 PM, Santosh Shilimkar wrote:

>>> So just stick the IP version or call it cpsw-v1... cpsw-v2 etc.
>>
>> If this could be handled using IP version then the right way would be to
>> just read the IP version from hardware and use it. No need of DT property.
>>
> Thats fine as well but I thought the patch needed additional properties like
> CM reg-address come from DT and hence the separate compatible. If you can
> manage without that, thats even better.

We can't, that's the whole point :)

Well, theoretically, we could for now, but that's not a clean solution.
Again: the problem here is that the control port is separated from the
cpsw core, and so we have to implement something specific for the AM3352
SoC. I know that's a violation of clean and generic driver ideas, but
there's no way we can assume that every cpsw v2 ip block has a control
port that is compatible to the one found on am335x chips.


Daniel
