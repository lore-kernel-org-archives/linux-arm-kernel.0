From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Oct 2013 13:08:51 -0600
Subject: [PATCH v3 09/19] clk: tegra: add clkdev registration infra
In-Reply-To: <1381848794-11761-10-git-send-email-pdeschrijver@nvidia.com>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
 <1381848794-11761-10-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <525D92C3.9070507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2013 08:52 AM, Peter De Schrijver wrote:
> Add a common infra for registering clkdev. This allows decoupling clk
> registration from clkdev registration.

>  drivers/clk/tegra/clk-tegra114.c |  322 +++++++++++++++++++-------------------
>  drivers/clk/tegra/clk.c          |    9 +
>  drivers/clk/tegra/clk.h          |    7 +

It seems a little odd to have a patch which adds infra-structure and
converts Tegra114 alone, but not Tegra20/Tegra30. I would have expected
either:

* Patch to add infra-structure
* Patch to convert Tegra20
* Patch to convert Tegra30
* Patch to convert Tegra114

or:

* Patch to add infra-structure and convert Tegra20, Tegra30, and Tegra114.

Still, I suppose this isn't a particular problem, just something that
feels odd, so no need to split up all the patches to fit one of those
models. Just something to bear in mind next time.
