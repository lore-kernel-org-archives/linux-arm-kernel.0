From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 2 Aug 2016 19:42:54 +0200
Subject: [PATCH 0001/1285] Replace numeric parameter like 0444 with macro
In-Reply-To: <20160802103322.13810-1-baolex.ni@intel.com>
References: <20160802103322.13810-1-baolex.ni@intel.com>
Message-ID: <20160802174253.GA4628@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.

> -core_param(no_bL_switcher, no_bL_switcher, bool, 0644);
> +core_param(no_bL_switcher, no_bL_switcher, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);

Everyone knows what 0644 is, but noone can read S_IRUSR | S_IWUSR |
S_IRCRP | S_IROTH (*). Please don't do this.

									Pavel
















































(*) I deliberately included an error there. Did you spot the error?
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
