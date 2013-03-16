From: bilhuang@nvidia.com (Bill Huang)
Date: Fri, 15 Mar 2013 19:23:19 -0700
Subject: [RFC 1/1] clk: Add notifier support in
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <CAPDyKFpHz6KCNbVe2AsDuzZw-oN7NyRzCA=RatWA+9iMaQ7C+Q@mail.gmail.com>
References: <1363151317.3311.9.camel@bilhuang-vm1>
 <51400D9D.9060305@wwwdotorg.org>	<1363153204.3311.14.camel@bilhuang-vm1>
 <5140C12A.4060900@wwwdotorg.org>	<1363227311.3311.30.camel@bilhuang-vm1>
 <20130314092132.GE18519@tbergstrom-lnx.Nvidia.com>
 <1363253287.3311.32.camel@bilhuang-vm1>	<51420EBB.7080503@wwwdotorg.org>
 <1363310454.3311.44.camel@bilhuang-vm1>	<5142B027.4040403@wwwdotorg.org>
 <20130315093951.GV18519@tbergstrom-lnx.Nvidia.com>
 <CAPDyKFoBJpraMz8i1FmFqG7=Zsv0DTQ0PKVOQJ-+iEsKpb3Hdg@mail.gmail.com>
 <1363349206.5827.10.camel@bilhuang-vm1>
 <CAPDyKFpHz6KCNbVe2AsDuzZw-oN7NyRzCA=RatWA+9iMaQ7C+Q@mail.gmail.com>
Message-ID: <1363400599.2879.18.camel@bilhuang-vm1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-03-15 at 20:33 +0800, Ulf Hansson wrote:
> I guess you did not fully got what I meant with "dvfs clock type". It
> will not affect the clock API. But instead the dvfs is handled by
> implementing a specific clk hw type. So the same thing is accomplished
> as with clk notifiers, no changes should be needed to device drivers.
> 
> The difference is only that no notifiers will be needed, and all the
> dvfs stuff will be handled in the clk hw instead. It will mean that we
> will bundle dvfs stuff into the clock drivers, instead of separating
> the code outside the clock drivers. But, on the other hand no
> notifiers will be needed.
> 
Oh yes I misunderstand your origin point, but my thought is using
existing devfreq framework as frequency/voltage policy driver instead of
creating another one in clock driver and that's why I think we need the
notifier work. 

By the way, some centralized DVFS implementation like Tegra's VDD_CORE
rail has association with tens of clocks which will need to be taken
care specially if we're doing those in clock driver I think.

> Kind regards
> Ulf Hansson
