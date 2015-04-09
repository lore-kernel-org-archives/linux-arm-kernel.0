From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Apr 2015 15:55:58 +0100
Subject: [PATCH] coresight: etb10: Print size of buffer we fail to allocate
In-Reply-To: <CANLsYkzoj5nPs2dnejOsDgEHZXArbXq5s6B7Cp3P1siu0Vv8YA@mail.gmail.com>
References: <1428531327-16902-1-git-send-email-broonie@kernel.org>
 <CANLsYkzoj5nPs2dnejOsDgEHZXArbXq5s6B7Cp3P1siu0Vv8YA@mail.gmail.com>
Message-ID: <20150409145558.GW6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 08:46:55AM -0600, Mathieu Poirier wrote:

> I'll take this patch but will rework the commit message a little.  If
> the power domains are not setup properly the device won't show up on
> AMBA and as such won't get probed.

This depends on what the hardware does and how the device is registered
- if the device is registered with an ID provided (which you can do)
then AMBA won't bother reading the ID back and verifying that it's
correct so there's no interaction with the hardware until we hit the
driver.

I've not checked the DT case, though it doesn't seem like there's any
check that the compatible string matches the ID read from the hardware
which is a bit interesting...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/4a4978ff/attachment.sig>
