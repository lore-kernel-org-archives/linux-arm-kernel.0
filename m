From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 19 Aug 2016 21:47:34 +0100
Subject: [PATCH v1 2/3] of: Add support for reading a s32 from a
 multi-value property.
In-Reply-To: <4975010.IL95Y3Sj1J@phil>
References: <1471315139-28285-1-git-send-email-finley.xiao@rock-chips.com>
 <1471315139-28285-3-git-send-email-finley.xiao@rock-chips.com>
 <1471616119.61594.465.camel@infradead.org> <4975010.IL95Y3Sj1J@phil>
Message-ID: <1471639654.4611.2.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-08-19 at 22:41 +0200, Heiko Stuebner wrote:
> 
> > So no, don't *add* any more of these functions. Only add the generic
> > version. And if your driver isn't using the generic property
> > functions... fix it.
> 
> As far as I can see, all the device_property_* functions are grounded on their
> of_property_*, acpi_property_* etc counterparts and functions reading specific
> elements (the _index variants) are currently not available at all.
> 
> drivers/base/property.c:
> #define OF_DEV_PROP_READ_ARRAY(node, propname, type, val, nval)?????????????????????????\
> ????????(val) ? of_property_read_##type##_array((node), (propname), (val), (nval))??????\
> ????????????? : of_property_count_elems_of_size((node), (propname), sizeof(type))
> 
> So even if you're using the device_property_* functions you'd still need
> a match in the underlying functions or am I missing something?

Yes, but the underlying function should never be used directly by
drivers. And should probably be prefixed with __ or marked deprecated
(with an override in its one genuine call site).

-- 
dwmw2


-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5760 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160819/9c638728/attachment.bin>
