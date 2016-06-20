From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 Jun 2016 10:45:55 -0600
Subject: [PATCH v2] arm: tegra124: remove commas from unit addresses
In-Reply-To: <20160620164057.GD6175@ulmo.ba.sec>
References: <1466298275-15753-1-git-send-email-marcel.ziswiler@toradex.com>
 <576810C2.1030401@wwwdotorg.org> <20160620164057.GD6175@ulmo.ba.sec>
Message-ID: <57681DC3.9090801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2016 10:40 AM, Thierry Reding wrote:
> On Mon, Jun 20, 2016 at 09:50:26AM -0600, Stephen Warren wrote:
>> On 06/18/2016 07:04 PM, Marcel Ziswiler wrote:
>>> Remove commas from unit addresses as suggested by Rob Herring upon me
>>> posting initial Apalis TK1 support:
>>>
>>> http://article.gmane.org/gmane.linux.ports.tegra/26608
>>
>> Acked-by: Stephen Warren <swarren@nvidia.com>
>
> I'm confused now. I posted almost exactly the same patch a while ago and
> we agreed that we couldn't do this because the node names were to be
> considered part of the ABI.
>
> Is it or is it not?

The particular case where it matters is the GPU node, which U-Boot 
manipulates. This revised patch version no longer renames the GPU node 
and so in practice avoids any issues that I'm aware of.

If there's a more general rule that node names are part of the ABI, then 
indeed we shouldn't take this patch.
