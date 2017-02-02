From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 2 Feb 2017 07:48:35 +0100
Subject: [PATCH v2 3/4] phy: Add USB3 PHY support for Broadcom NSP SoC
In-Reply-To: <1484669670-4201-4-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <6be62ef6-e90c-b5f8-adcd-0ea62ab73ced@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Resending with fixed/complete Cc-s]

On Tue, 17 Jan 2017 11:14:29 -0500, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com> wrote:> This patch adds support for Broadcom NSP USB3 PHY
 >
 > Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>

Seriously?! I really dislike what you did there.

NACK.

You are aware this block is common for both: Northstar and Northstar Plus and
we already have phy-bcm-ns-usb3.c! In fact Jon told me to rewrite my initial
driver to make is possible to reuse it on NSP and I did that!

This is old comment from Jon:

In 30 March 2016 at 23:31, Jon Mason <jon.mason@broadcom.com> wrote:
 > On Mon, Mar 28, 2016 at 9:46 PM, Florian Fainelli <f.fainelli@gmail.com>
 > wrote:
 >>
 >> CC: bcm-kernel-feedback-list, Jon
 >
 >
 > This is a common IP block with NSP.  I believe with some minor changes it
 > can support both.  Please allow me 1-2 days to look at these in more detail
 > and see if I can get these patches working on NSP.

Please start using existing code instead of inventing everything from the
scratch internally at Broadcom. You did the same thing with (Q)SPI driver.


This driver duplicates phy-bcm-ns-usb3.c and should have not been accepted. I
strongly suggest *reverting* it and adjusting existing driver if needed.
