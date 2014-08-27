From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 27 Aug 2014 18:30:54 +0200
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <53FE05AE.9000406@wwwdotorg.org>
References: <53F64624.5000403@ahsoftware.de>
 <20140822131919.GX21734@leverpostej> <20140825093931.GB2399@ulmo>
 <E1XLu15-0002DP-6o@jdl.com> <20140825133714.GH4163@ulmo.nvidia.com>
 <20140826084208.AE5F0C40989@trevor.secretlab.ca>
 <20140826084922.GG17263@ulmo> <53FC566C.30904@ahsoftware.de>
 <20140826101107.GC32315@leverpostej>
 <20140827103432.64927C409CB@trevor.secretlab.ca>
 <20140827144403.GB13850@arm.com> <53FE05AE.9000406@wwwdotorg.org>
Message-ID: <53FE07BE.7000809@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.08.2014 18:22, schrieb Stephen Warren:
> On 08/27/2014 08:44 AM, Catalin Marinas wrote:

>> It's not just optimisation but an important feature for new arm64 SoCs.
>> Given some Tegra discussions recently, in many cases the machine_desc
>> use on arm is primarily to initialise devices in the right order. If we
>> can solve this in a more deterministic way (other than deferred
>> probing), we avoid the need for a dedicated SoC platform driver (or
>> machine_desc) or workarounds like different initcall levels and explicit
>> DT parsing.
>
> A lot of the ordering is SW driver dependencies. I'm not sure how much
> of that can accurately be claimed as HW dependencies. As such, I'm not
> sure that putting dependencies into DT would be a good idea; it doesn't
> feel like HW data, and might well change if we restructure SW. It'd need
> some detailed research though.

Almost every phandle is a dependency, so the DT is already full with them.
