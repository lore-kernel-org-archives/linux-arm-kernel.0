From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 26 Aug 2014 11:02:46 +0300
Subject: [PATCH 0/8] Tegra124 EMC (external memory controller) support
In-Reply-To: <20140826074750.GA17263@ulmo>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
 <53FB7511.9090205@wwwdotorg.org> <53FC3A5D.8030708@nvidia.com>
 <20140826074750.GA17263@ulmo>
Message-ID: <53FC3F26.6010704@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/14 10:47, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Tue, Aug 26, 2014 at 10:42:21AM +0300, Mikko Perttunen wrote:
>> On 25/08/14 20:40, Stephen Warren wrote:
>>> On 07/11/2014 08:18 AM, Mikko Perttunen wrote:
>>>> Hi everyone,
>>>>
>>>> this series adds support for the EMC (external memory controller) clock
>>>> in the Tegra124 system-on-chip. The series has been tested on Jetson TK1.
>>>>
>>>> The first two patches remove the old "emc_mux" and "emc" clocks from the
>>>> clock tree and the device tree bindings. This is, of course, not
>>>> backwards
>>>> compatible, but as these clocks have never been useful for anything
>>>> (apart from maybe reading the boot rate of the EMC clock). If this is
>>>> still
>>>> not acceptable, the second patch can be dropped.
>>> ...
>>>
>>> Mikko, this series had some comments, especially on the DT binding
>>> (patch 5/8) and how the MC/EMC drivers interact. Is there an updated
>>> version of the series? Or, is the series replaced by Tomeu Vizoso's work?
>>
>> Yes, I have a v2 with these comments addressed. One concern, though, is the
>> part writing to CLK_SOURCE_EMC. If some other driver also wants to read this
>> register (MC, likely), we might need to have an API for it in the CAR
>> driver. On the other hand, maybe not, since it's only one register. Thierry?
>
> I don't think any of these drivers should directly access registers that
> aren't in the memory region that they've claimed. If they need to access
> functionality provided by some other driver then they should do so via a
> custom API.

I'll make a simple API and post patches.

>
> Thierry
>
> * Unknown Key
> * 0x7F3EB3A1
>

Mikko
