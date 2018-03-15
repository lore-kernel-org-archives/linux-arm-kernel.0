From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 15 Mar 2018 17:48:36 +0100
Subject: [PATCHv2 3/7] driver, misc: add Intel Stratix10 service layer
 driver
In-Reply-To: <1519949975-13548-4-git-send-email-richard.gong@linux.intel.com>
References: <1519949975-13548-1-git-send-email-richard.gong@linux.intel.com>
 <1519949975-13548-4-git-send-email-richard.gong@linux.intel.com>
Message-ID: <20180315164836.GB4060@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 06:19:31PM -0600, richard.gong at linux.intel.com wrote:
> +EXPORT_SYMBOL_GPL(request_svc_channel_byname);

All of your global symbols should have the same prefix, not a verb.  So
this should be:
	svc_channel_request_by_name(), right?

> +EXPORT_SYMBOL_GPL(free_svc_channel);

svc_channel_free()?

> +EXPORT_SYMBOL_GPL(intel_svc_send);

Wait, why doesn't the first ones have "intel_svc" in them?

What is the difference here?

Should they all just have "intel_svc_" as the prefix?

Stick to one thing for all exported functions/variables please, it's the
only way we can attempt to keep our namespace "sane".

Also, why would a 'misc' driver be exporting things that something else
uses?  Why not just put this in the fpga directory next to the users of
this code?

thanks,

greg k-h
