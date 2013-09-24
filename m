From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 24 Sep 2013 11:08:30 +0300
Subject: [PATCH 05/12] clk: tegra: add header for common tegra clock IDs
In-Reply-To: <524082E3.8070801@wwwdotorg.org>
References: <1379515331-19427-1-git-send-email-pdeschrijver@nvidia.com>
 <1379515331-19427-6-git-send-email-pdeschrijver@nvidia.com>
 <524082E3.8070801@wwwdotorg.org>
Message-ID: <20130924080830.GI30013@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 08:05:23PM +0200, Stephen Warren wrote:
> On 09/18/2013 08:40 AM, Peter De Schrijver wrote:
> > Many clocks are common between several Tegra SoCs. Define an enum to list
> > them so we can move them to separate files which can be shared between
> > SoCs. Each SoC specific file will provide an array with the common clocks
> > which are present on the SoC and their DT binding ID.
> 
> So, this enum is purely something internal to the driver, and is in no
> way related to the DT binding clock IDs, nor the HW peripheral clock
> register bits, and finally is a union of all extant clocks across all chips?
> 

Yes. Although there will still be the possibility to have clocks outside this
union for a while. At least until Tegra20 and Tegra30 are migrated as well.

Cheers,

Peter.
