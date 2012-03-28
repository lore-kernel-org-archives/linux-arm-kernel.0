From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 17:13:05 +0100
Subject: [PATCH] ARM: pxa: fix build failure for regulator consumer in
 em-x270.c
In-Reply-To: <4F73356D.5080401@windriver.com>
References: <CAP=VYLp-weNj35OHtmZ6pf5-t7OUxWREeu8r5sSOLhFYu0CppQ@mail.gmail.com>
 <1331244366-6147-1-git-send-email-paul.gortmaker@windriver.com>
 <4F732C97.2030804@compulab.co.il>
 <20120328152743.GW3232@opensource.wolfsonmicro.com>
 <4F73356D.5080401@windriver.com>
Message-ID: <20120328161305.GZ3232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 11:59:41AM -0400, Paul Gortmaker wrote:
> On 12-03-28 11:27 AM, Mark Brown wrote:

> static struct platform_device em_x270_gps_userspace_consumer = {
>         .name           = "reg-userspace-consumer",
>         .id             = 0,

> static struct platform_device em_x270_gprs_userspace_consumer = {
>         .name           = "reg-userspace-consumer",
>         .id             = 1,

> Note that the existing names currently don't incorporate the .id
> field as a suffix, and so never were unique.

No, this is just a basic part of how platform devices work - the device
name is always the same and if you've got more than one of them they get
different .ids.  dev_name() returns name.id, or just name if id is set
to -1 indicating that there's onyl one device of a given type.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120328/6c767616/attachment.sig>
