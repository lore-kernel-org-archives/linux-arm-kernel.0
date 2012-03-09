From: sdharia@codeaurora.org (Sagar Dharia)
Date: Fri, 09 Mar 2012 12:50:24 -0700
Subject: [RFC PATCH] slimbus message encoding/decoding
In-Reply-To: <20120309002106.GA605@plastictigers.com>
References: <20120309002106.GA605@plastictigers.com>
Message-ID: <4F5A5F00.70508@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/08/2012 05:21 PM, Marc Butler wrote:
> All,
>
> This patch provides generic functions for encoding/decoding SLIMbus
> messages (Section 8 of the specification).

Thanks for providing this patch. My understanding is that this patch 
provides helper functions for h/w controllers which rely on s/w to 
provide the exact message to be sent out on the bus.

> No CRC generator is included for the PI and MI fields. The OMAP4430
> chip this is being tested on generates and populates these fields in
> h/w. However, I have include a general (and untested) callback
> mechanism.

Just like CRC, some other fields may be populated by HW. e.g. Qualcomm 
chip also populates Arbitration priority, Arbitration Extension fields. 
So it expects SW to only program a few fields, a.k.a logical/elemental 
address, MT,MC, DT etc.(that too, SW programs this based on software 
interface manual). The hardware will convert this information to actual 
slimbus-compliant message and send it on the bus.

Being said that, I am not aware of how majority of h/w controllers work 
and will be open to have this patch if other hardwares rely on s/w to 
provide the exact message as well.

-Sagar
> -m

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
