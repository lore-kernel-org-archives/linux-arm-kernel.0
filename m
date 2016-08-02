From: joe@perches.com (Joe Perches)
Date: Tue, 02 Aug 2016 10:52:18 -0700
Subject: [PATCH 0001/1285] Replace numeric parameter like 0444 with macro
In-Reply-To: <20160802174253.GA4628@amd>
References: <20160802103322.13810-1-baolex.ni@intel.com>
 <20160802174253.GA4628@amd>
Message-ID: <1470160338.3998.193.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-08-02 at 19:42 +0200, Pavel Machek wrote:
> > I find that the developers often just specified the numeric value
> > when calling a macro which is defined with a parameter for access permission.
> > As we know, these numeric value for access permission have had the corresponding macro,
> > and that using macro can improve the robustness and readability of the code,
> > thus, I suggest replacing the numeric parameter with the macro.
> > 
> > -core_param(no_bL_switcher, no_bL_switcher, bool, 0644);
> > +core_param(no_bL_switcher, no_bL_switcher, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

> Everyone knows what 0644 is, but noone can read S_IRUSR | S_IWUSR |
> S_IRCRP | S_IROTH (*). Please don't do this.

Perhaps this conversion is best done in reverse with
most all of the S_[A-Z]{5,5} uses converted to octal.
