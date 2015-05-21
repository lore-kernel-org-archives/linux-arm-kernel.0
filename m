From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 21 May 2015 11:19:35 +0530
Subject: [PATCH V5 3/3] OPP: Add binding for 'opp-suspend'
In-Reply-To: <555D6DD3.7000404@ti.com>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
 <618b02107af650bcb3246e165095bbca207d511a.1432091956.git.viresh.kumar@linaro.org>
 <555D6DD3.7000404@ti.com>
Message-ID: <20150521054935.GG22904@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-05-15, 00:32, Nishanth Menon wrote:
> Why not just mark it as a property of an OPP rather than a phandle? just
> thinking that this might setup a precedence for future needs like
> "shutdown OPP" or "Reboot OPP" or something different that some other
> SoC might have..

AFAIU, a property should be present in the OPP if and only if any OPP
can set it. But in this case, only one OPP from the entire list can
set it. So, its more a property of the list rather than every OPP
within it. And then there wouldn't be any need to code that would
check bugs in dtbs where multiple OPPs have it set.

-- 
viresh
