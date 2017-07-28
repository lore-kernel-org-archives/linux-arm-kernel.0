From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 28 Jul 2017 16:55:06 -0700
Subject: [PATCH v2] ARM: dts: bcm283x: Move the BCM2837 DT contents from
 arm64 to arm.
In-Reply-To: <20170726200156.30161-1-eric@anholt.net>
References: <20170726200156.30161-1-eric@anholt.net>
Message-ID: <18c414ac-c58e-bf99-1d04-8fed2c4a0300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2017 01:01 PM, Eric Anholt wrote:
> BCM2837 is somewhat unusual in that we build its DT on both arm32 and
> arm64.  Most devices are being run in arm32 mode.
> 
> Having the body of the DT for 2837 separate from 2835/6 has been a
> source of pain, as we often need to make changes that span both
> directories simultaneously (for example, the thermal changes for 4.13,
> or anything that changes the name of a node referenced by '&' from
> board files).  Other changes are made more complicated than they need
> to be, such as the SDHOST enabling, because we have to split a single
> logical change into a 283[56] half and a 2837 half.
> 
> To fix this, make the stub board include file live in arm64 instead of
> arm32, and keep all of BCM283x's contents in arm32.  From here on, our
> changes to DT contents can be submitted through a single tree.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Applied to devicetree/next (arm64), thanks Eric!

-- 
Florian
