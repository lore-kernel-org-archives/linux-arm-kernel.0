From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 10 Jul 2012 22:23:48 +0530
Subject: [PATCH 1/3] ARM: dt: tegra: seaboard: add regulators
In-Reply-To: <20120710165236.GI10022@opensource.wolfsonmicro.com>
References: <4FE882A5.3080504@nvidia.com>
 <20120625222646.GB30406@opensource.wolfsonmicro.com>
 <4FE8EFC4.3090509@wwwdotorg.org> <4FFC190A.2040800@nvidia.com>
 <20120710134436.GD9409@opensource.wolfsonmicro.com>
 <4FFC31D5.7090600@nvidia.com>
 <20120710135302.GG9409@opensource.wolfsonmicro.com>
 <4FFC4478.7000204@nvidia.com>
 <20120710154201.GE10022@opensource.wolfsonmicro.com>
 <4FFC5ACA.8010003@nvidia.com>
 <20120710165236.GI10022@opensource.wolfsonmicro.com>
Message-ID: <4FFC5E1C.7000500@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 July 2012 10:22 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Tue, Jul 10, 2012 at 10:09:38PM +0530, Laxman Dewangan wrote:
>
>> Do we need to make such supply pin entry as required inplace of optional?
> That's the idea.

Then I will have 2 question:
1. If that pin is connected to battery then what should be entry?
    vcc1-supply = <>>>;
Do we need to register battery supply as fixed (non-gpio based) and then 
refer here for phandle?

2. what about non-dt case? The regulator registration will also fail 
here because of there is no regulator saying vcc1 in this case. Do we 
need to register the vcc1 regualtor as fixed, battery supplied regulator 
in board files so that the ldo's registration will success?
