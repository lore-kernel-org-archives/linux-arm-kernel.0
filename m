From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Fri, 29 Sep 2017 15:44:27 +0200
Subject: [PATCH] extcon: Split out extcon header file for consumer and
 provider device
In-Reply-To: <1506643305-4581-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20170929000148epcas2p200e56186b067ec626a033c7ae2d4bbdb@epcas2p2.samsung.com>
 <1506643305-4581-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <20170929134427.wcsne3pf6qobw6ra@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 29, 2017 at 09:01:45AM +0900, Chanwoo Choi wrote:
> The extcon has two type of extcon devices as following.
> - 'extcon provider deivce' adds new extcon device and detect the
>    state/properties of external connector. Also, it notifies the
>    state/properties to the extcon consumer device.
> - 'extcon consumer device' gets the change state/properties
>    from extcon provider device.
> Prior to that, include/linux/extcon.h contains all exported API for
> both provider and consumer device driver. To clarify the meaning of
> header file and to remove the wrong use-case on consumer device,
> this patch separates into extcon.h and extcon-provider.h.
> 
> [Description for include/linux/{extcon.h|extcon-provider.h}]
> - extcon.h includes the extcon API and data structure for extcon consumer
>   device driver. This header file contains the following APIs:
>   : Register/unregister the notifier to catch the change of extcon device
>   : Get the extcon device instance
>   : Get the extcon device name
>   : Get the state of each external connector
>   : Get the property value of each external connector
>   : Get the property capability of each external connector
> 
> - extcon-provider.h includes the extcon API and data structure for extcon
>   provider device driver. This header file contains the following APIs:
>   : Include 'include/linux/extcon.h'
>   : Allocate the memory for extcon device instance
>   : Register/unregister extcon device
>   : Set the state of each external connector
>   : Set the property value of each external connector
>   : Set the property capability of each external connector
> 

[...]

>  drivers/power/supply/qcom_smbb.c              |   2 +-

[...]

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170929/85b2cbac/attachment.sig>
