From: jon.mason@broadcom.com (Jon Mason)
Date: Fri, 3 Feb 2017 11:05:26 -0500
Subject: [PATCH v2 3/4] phy: Add USB3 PHY support for Broadcom NSP SoC
In-Reply-To: <6be62ef6-e90c-b5f8-adcd-0ea62ab73ced@gmail.com>
References: <1484669670-4201-4-git-send-email-yendapally.reddy@broadcom.com>
 <6be62ef6-e90c-b5f8-adcd-0ea62ab73ced@gmail.com>
Message-ID: <CAC3K-4oUCY4g6b1_++5io-Ls=73jNvMZ9L7P9OgCwVWe6srqoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 2, 2017 at 1:48 AM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> [Resending with fixed/complete Cc-s]
>
> On Tue, 17 Jan 2017 11:14:29 -0500, Yendapally Reddy Dhananjaya Reddy
> <yendapally.reddy@broadcom.com> wrote:> This patch adds support for Broadcom
> NSP USB3 PHY
>>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy
>> <yendapally.reddy@broadcom.com>
>
> Seriously?! I really dislike what you did there.
>
> NACK.
>
> You are aware this block is common for both: Northstar and Northstar Plus
> and
> we already have phy-bcm-ns-usb3.c! In fact Jon told me to rewrite my initial
> driver to make is possible to reuse it on NSP and I did that!
>
> This is old comment from Jon:
>
> In 30 March 2016 at 23:31, Jon Mason <jon.mason@broadcom.com> wrote:
>> On Mon, Mar 28, 2016 at 9:46 PM, Florian Fainelli <f.fainelli@gmail.com>
>> wrote:
>>>
>>> CC: bcm-kernel-feedback-list, Jon
>>
>>
>> This is a common IP block with NSP.  I believe with some minor changes it
>> can support both.  Please allow me 1-2 days to look at these in more
>> detail
>> and see if I can get these patches working on NSP.
>
> Please start using existing code instead of inventing everything from the
> scratch internally at Broadcom. You did the same thing with (Q)SPI driver.
>
>
> This driver duplicates phy-bcm-ns-usb3.c and should have not been accepted.
> I
> strongly suggest *reverting* it and adjusting existing driver if needed.

I agree that we need to be heading in the same direction with 4708/9
(Northstar) and Northstar+.  Duplication of work is a sin (and if not,
it should be).  So, I apologize for this and let's move forward
together.

Regarding the SPI duplication of drivers, the QSPI driver covers a
much broader array of SoCs across Broadcom, and was a joint effort
between multiple teams internally.  To resolve this, I believe the
best way forward is to add QSPI to the 4708/9 device trees, and remove
the BSPI driver from Linux.  I'll have someone work on this internally
and get it out ASAP.

Regarding the duplication of function for the USB PHYs, the MDIO bus
for our PHYs is the way we would like to support everything going
forward.  This MDIO bus supports more than just USB.  So, it will be
much more extensible in the future.  Since there is already a USB PHY
driver for NS, I would recommend that we modify that driver to have
MDIO support.  If we are in agreement, Kishon can drop the current
series in his tree and Dhananjay will abandon the unaccepted ones.

Thanks,
Jon
