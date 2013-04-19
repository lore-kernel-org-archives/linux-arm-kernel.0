From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 19 Apr 2013 16:22:56 +0530
Subject: [PATCH v3 0/6] Generic PHY Framework
In-Reply-To: <1363770725-13717-1-git-send-email-kishon@ti.com>
References: <1363770725-13717-1-git-send-email-kishon@ti.com>
Message-ID: <51712208.5090403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On 3/20/2013 2:41 PM, Kishon Vijay Abraham I wrote:
> Added a generic PHY framework that provides a set of APIs for the PHY drivers
> to create/destroy a PHY and APIs for the PHY users to obtain a reference to
> the PHY with or without using phandle. To obtain a reference to the PHY
> without using phandle, the platform specfic intialization code (say from board
> file) should have already called phy_bind with the binding information. The
> binding information consists of phy's device name, phy user device name and an
> index. The index is used when the same phy user binds to mulitple phys.
> 
> This framework will be of use only to devices that uses external PHY (PHY
> functionality is not embedded within the controller).

>From a top level what you are doing looks closely related to External
connector (extcon).

I understand a connector is not the same as a phy, but it will still be
useful to know why extcon framework (or some extension of it) will not
suffice your needs.

You can probably note it in the cover-letter so folks like me get their
answer.

Thanks,
Sekhar
