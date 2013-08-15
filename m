From: robherring2@gmail.com (Rob Herring)
Date: Thu, 15 Aug 2013 07:37:04 -0500
Subject: [PATCH 0/3] of: add update device node status via cmdline feature
In-Reply-To: <1376564133-11286-1-git-send-email-b29396@freescale.com>
References: <1376564133-11286-1-git-send-email-b29396@freescale.com>
Message-ID: <520CCB70.8090908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/15/2013 05:55 AM, Dong Aisheng wrote:
> We meet some boards having a lot of pin conflicts between different devices,
> only one of them can be enabled to run at one time.
> 
> e.g. imx6q sabreauto board, i2c, spi, weim, flexcan, uart and etc involved
> with pin conflict.
> 
> Instead of changing dts manually or adding a lot dts files according to
> different device availability, we provide feature to dynamically update the
> device node status via command line, then those devices involved with
> pin conflict can be enabled or disabled dynamically.
> 
> It's conveniently to use and can save a lot dts board files, also can
> permenantly fix the pin conflicts issue.

This doesn't scale either with updating of lots devices or when the next
person comes along and wants to edit another property.

This is something u-boot is perfectly capable of handling and updating
status is something lots of boards already do.

Rob

> 
> The patch series is based on v3.11-rc5.
> 
> Dong Aisheng (3):
>   of: add device node status update APIs
>   of: add update device node status via cmdline feature
>   of: add node status update via name format with cmdline
> 
>  Documentation/kernel-parameters.txt |   10 +++
>  drivers/of/base.c                   |  107 +++++++++++++++++++++++++++++++++
>  drivers/of/fdt.c                    |  111 +++++++++++++++++++++++++++++++++++
>  include/linux/of.h                  |   13 ++++
>  4 files changed, 241 insertions(+), 0 deletions(-)
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
