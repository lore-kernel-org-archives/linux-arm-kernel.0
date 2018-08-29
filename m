From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 29 Aug 2018 20:10:39 +0300
Subject: [PATCH v4 1/2] clk: Add of_clk_get_by_name_optional() function
In-Reply-To: <1533039060-18779-2-git-send-email-phil.edworthy@renesas.com>
References: <1533039060-18779-1-git-send-email-phil.edworthy@renesas.com>
 <1533039060-18779-2-git-send-email-phil.edworthy@renesas.com>
Message-ID: <20180829171039.GD11447@smile.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 01:10:59PM +0100, Phil Edworthy wrote:
> Quite a few drivers get an optional clock, e.g. a clock required
> to access peripheral's registers that is always enabled on some
> devices.
> 
> This function behaves the same as of_clk_get_by_name() except that
> it will return NULL instead of -ENOENT.

> +		if (optional && (index == -EINVAL || index == -ENODATA ||
> +		    PTR_ERR(clk) == -ENOENT)) {

A nit: I would rather rearrange this to be

if (optional &&
    (... || ... || ...)) {

(disregard 80 characters limit for second line)

-- 
With Best Regards,
Andy Shevchenko
