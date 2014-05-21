From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Wed, 21 May 2014 11:04:17 +0200
Subject: [PATCH] ARM: dts: duovero-parlor: Add HDMI output
In-Reply-To: <537C6322.2000101@ti.com>
References: <1400595946-1294-1-git-send-email-florian.vaussard@epfl.ch>
 <CAGhQ9VxtJwrKzW77mo=y9_gvCRW_8TJEp90OVN+YPg2RpC=b_w@mail.gmail.com>
 <537C6082.2000405@epfl.ch> <537C6322.2000101@ti.com>
Message-ID: <537C6C11.8010808@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/21/2014 10:26 AM, Tomi Valkeinen wrote:
> On 21/05/14 11:14, Florian Vaussard wrote:
> 
>>> I think Parlor has one and the "hdmi-connector" binding now
>>> supports it. See Tomi's 3.16/fbdev-omap branch.
>>> 
>> 
>> Looking into the details, the HPD pin of the parlor board is
>> connected to the OMAP4 HDMI IP. The LINK_CONNECT and
>> LINK_DISCONNECT events are managed by hdmi_irq_handler() in
>> hdmi4.c to turn on/off the PHY's power. So there is no need to
>> use the hgp-gpios binding of "hdmi-connector" IMHO. Correct me if
>> I am wrong, as the public TRM is pretty thin regarding the OMAP4
>> HDMI IP.
> 
> The PHY's link-connect and disconnect are a separate thing, not
> really related to the HPD.
> 
> The hdmi_hpd pin on OMAP should be configured to GPIO mode, and the
> GPIO should be handled by the hdmi-connector.
> 
> The HDMI driver doesn't have support for the HDMI IP's HPD, and if
> I recall right, the HDMI IP's HPD was not without problems. And
> afaik it doesn't really bring anything, a normal GPIO does the job
> just fine.
> 

I see. I will use the pin as a GPIO, and post a v2.

Regards,
Florian
