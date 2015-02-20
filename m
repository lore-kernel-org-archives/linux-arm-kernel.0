From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 20 Feb 2015 13:46:42 +0200
Subject: [PATCH 9/9] RFC: ARM: DRA7: enable DSS_DESHDCP_CLKEN
In-Reply-To: <54DE1B7E.10505@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>	<1423840286-18377-10-git-send-email-tomi.valkeinen@ti.com>
 <CAGo_u6p89ot-eNwK65otoYsLM6NXeh929=SBG6uKAsX8Tnd_RQ@mail.gmail.com>
 <54DE1B7E.10505@ti.com>
Message-ID: <54E71EA2.3030803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/02/15 17:42, Tero Kristo wrote:
> On 02/13/2015 05:25 PM, Nishanth Menon wrote:

>> I would probably wait for control module to become syscon and probably
>> model this as syscon clk - I thin we should be seeing a series
>> sometime soon.
> 
> Yeah, I will be posting a series in a bit, just running some final tests
> on it.

I did the above with Tero's series. Adding the DES HDCP clock works ok.

However, I'm not able to do this in HWMOD framework. To enable the DSS
IP block I need to enable both the DSS func clock and the DES HDCP
clock, but the HWMOD framework only allows one mainclock.

I added the HDCP clock as an opt clock, but those are not enabled
intially by the HWMOD framework, and the call in omap_hwmod.c:_enable()
to soc_ops.wait_target_ready(oh) calls fails.

So... Any ideas how to proceed?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150220/960560ce/attachment.sig>
