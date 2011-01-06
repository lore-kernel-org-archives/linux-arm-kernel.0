From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 6 Jan 2011 12:18:53 -0800
Subject: [PATCH V2] ST SPEAr: PCIE gadget suppport
In-Reply-To: <137dfad4a093ea0ac80396f5eb7fbf0c382be698.1294314772.git.viresh.kumar@st.com>
References: <137dfad4a093ea0ac80396f5eb7fbf0c382be698.1294314772.git.viresh.kumar@st.com>
Message-ID: <20110106121853.016fb990.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Jan 2011 17:29:10 +0530
Viresh Kumar <viresh.kumar@st.com> wrote:

> From: Pratyush Anand <pratyush.anand@st.com>
> 
> This is a configurable gadget. can be configured by sysfs interface. Any
> IP available at PCIE bus can be programmed to be used by host
> controller.It supoorts both INTX and MSI.
> By default, gadget is configured for INTX and SYSRAM1 is mapped to BAR0
> with size 0x1000
> 
> ...
>
> --- /dev/null
> +++ b/Documentation/misc-devices/spear-pcie-gadget.txt

Please recheck this documentation file - it contains a number of simple
typos.

>
> ...
>
> +	if (strict_strtoul(buf, 0, &config->requested_msi))
> +		return -EINVAL;

It doesn't matter much, but the code really should propagate the
strict_strtoul() return error code back to the caller, rather than
overwriting it with -EINVAL.
