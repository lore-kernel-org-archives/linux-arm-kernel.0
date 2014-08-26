From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 26 Aug 2014 10:42:21 +0300
Subject: [PATCH 0/8] Tegra124 EMC (external memory controller) support
In-Reply-To: <53FB7511.9090205@wwwdotorg.org>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
 <53FB7511.9090205@wwwdotorg.org>
Message-ID: <53FC3A5D.8030708@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/08/14 20:40, Stephen Warren wrote:
> On 07/11/2014 08:18 AM, Mikko Perttunen wrote:
>> Hi everyone,
>>
>> this series adds support for the EMC (external memory controller) clock
>> in the Tegra124 system-on-chip. The series has been tested on Jetson TK1.
>>
>> The first two patches remove the old "emc_mux" and "emc" clocks from the
>> clock tree and the device tree bindings. This is, of course, not
>> backwards
>> compatible, but as these clocks have never been useful for anything
>> (apart from maybe reading the boot rate of the EMC clock). If this is
>> still
>> not acceptable, the second patch can be dropped.
> ...
>
> Mikko, this series had some comments, especially on the DT binding
> (patch 5/8) and how the MC/EMC drivers interact. Is there an updated
> version of the series? Or, is the series replaced by Tomeu Vizoso's work?

Yes, I have a v2 with these comments addressed. One concern, though, is 
the part writing to CLK_SOURCE_EMC. If some other driver also wants to 
read this register (MC, likely), we might need to have an API for it in 
the CAR driver. On the other hand, maybe not, since it's only one 
register. Thierry?

Another point is that v2 adds a new API to the MC driver, which also 
doesn't exist yet. The EMC driver can technically work without the MC 
driver (but with a header for MC added), but I'm not sure the result 
would be very useful.

I believe the plan is that Tomeu's EMC code will be integrated into this 
EMC driver once both are ready.

Mikko
