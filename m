From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 Jan 2013 11:03:14 +0000
Subject: [RFC PATCH 1/7] ARM: common: vic: Parse interrupt and resume
 masks from device tree
In-Reply-To: <1357774909-29938-2-git-send-email-tomasz.figa@gmail.com>
References: <1357774909-29938-1-git-send-email-tomasz.figa@gmail.com>
 <1357774909-29938-2-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130110110314.GH20956@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 12:41:43AM +0100, Tomasz Figa wrote:

> +- interrupt-mask : Bit mask of valid interrupt sources (defaults to all valid)
> +- wakeup-mask : Bit mask of interrupt sources that can wake up the system
> +  (defaults to all allowed)

Should this really be configured in the VIC itself?  It seems like
something that might change at runtime (for example, due to the user
configuring wakes in sysfs).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/f067b762/attachment.sig>
