From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 26 Aug 2011 10:26:32 +0100
Subject: [PATCH v3 11/13] of: add property iteration helpers
In-Reply-To: <1314315824-9687-12-git-send-email-swarren@nvidia.com>
References: <1314315824-9687-1-git-send-email-swarren@nvidia.com>
	<1314315824-9687-12-git-send-email-swarren@nvidia.com>
Message-ID: <20110826092632.GB3926@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2011 at 05:43:42PM -0600, Stephen Warren wrote:
> This patch adds macros for_each_u32_property_value and
> for_each_string_property_value, which iterate over an array of values
> within a device-tree property. Usage is for example:
> 
> struct of_iter_string_prop iter;
> for_each_string_property_value(iter, np, "pins")
>         printk("Got value %s\n", iter.value);
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Nicely implemented!  For the !CONFIG_OF case, I *think* that 
of_iter_u32_prop and of_iter_string_prop can be empty struct's, but I 
wouldn't want to bet money on that!

Reviewed-by: Jamie Iles <jamie@jamieiles.com>
