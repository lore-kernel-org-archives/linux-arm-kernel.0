From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 18 Aug 2015 20:29:25 +0530
Subject: [PATCH v2 0/6] ARM: berlin: add cpufreq support
In-Reply-To: <20150818143911.GB12017@kwain>
References: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
 <CAOh2x=ke9NWa-GjL=c+RgEWWfsNeKvE2O9CRHmW2dG5mj8ATCg@mail.gmail.com>
 <20150818143911.GB12017@kwain>
Message-ID: <20150818145925.GF31148@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-08-15, 16:39, Antoine Tenart wrote:
> However, it seems the OPP-v2 table takes precedence over the old one.
> When a default OPP-v2 table is supplied in the device tree, if the
> bootloader supplies an OPP table the old way it won't be taken into
> account.
> 
> So if I understood correctly, this won't work here for the BG2Q.

Didn't understood it completely. Are you saying that your dtb will
have two operating-points tables ?

The deal is that for any device, parsing of opp-v2 will be attempted
first. If its not available, then opp-v1 will be tried. But this is
per-device. So, one device can have opp-v2 tables and other one can do
v1 type.

-- 
viresh
