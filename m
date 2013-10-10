From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 10 Oct 2013 11:51:36 +0300
Subject: [PATCH 4/5] clk: tegra124: Add new peripheral clocks
In-Reply-To: <52557D92.9050200@wwwdotorg.org>
References: <1380878014-22088-1-git-send-email-pdeschrijver@nvidia.com>
 <1380878014-22088-5-git-send-email-pdeschrijver@nvidia.com>
 <525487C7.6080103@wwwdotorg.org>
 <20131009081123.GB3973@tbergstrom-lnx.Nvidia.com>
 <52557D92.9050200@wwwdotorg.org>
Message-ID: <20131010085136.GP4233@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 06:00:18PM +0200, Stephen Warren wrote:
> On 10/09/2013 02:11 AM, Peter De Schrijver wrote:
> > On Wed, Oct 09, 2013 at 12:31:35AM +0200, Stephen Warren wrote:
> >> On 10/04/2013 03:12 AM, Peter De Schrijver wrote:
> >>> Tegra124 introduces a number of new peripheral clocks. This patch adds those
> >>> to the common peripheral clock code.
> >>
> >> Don't you need to add AFC[0..5] in this patch and/or patch 5?
> > 
> > AFC[0..5] are reset only nodes afaik. Up to now, we haven't done that.
> > The goal is to include them once we move to the reset framework.
> 
> No, we've always added clock entries for all reset-only clocks into the
> clock driver. Since the port to the reset framework is not available
> yet, we need to continue to do this. Otherwise, we won't be able to
> upstream audio support.
> 

The only clock which required this up to now was 'cop' (avp). Which is not
in upstream.

Cheers,

Peter.
