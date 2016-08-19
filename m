From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 19 Aug 2016 15:15:19 +0100
Subject: [PATCH v1 2/3] of: Add support for reading a s32 from a
 multi-value property.
In-Reply-To: <1471315139-28285-3-git-send-email-finley.xiao@rock-chips.com>
References: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com>
 <1471315139-28285-3-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <1471616119.61594.465.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-08-16 at 10:38 +0800, Finlye Xiao wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> This patch adds an of_property_read_s32_index() function to allow
> reading a single indexed s32 value from a property containing multiple
> s32 values.
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

NAK.

Nobody should be using the old of_property_* functions any more anyway.
You should be using the generic device_propery_* functions which work
regardless of where the information comes from (actual DT vs. ACPI
_DSD).

So no, don't *add* any more of these functions. Only add the generic
version. And if your driver isn't using the generic property
functions... fix it.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5760 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160819/51563e57/attachment.bin>
