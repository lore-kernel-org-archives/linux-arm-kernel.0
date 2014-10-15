From: balbi@ti.com (Felipe Balbi)
Date: Wed, 15 Oct 2014 11:55:02 -0500
Subject: [PATCH 00/12] rtc: omap: fixes and power-off feature
In-Reply-To: <1412881594-25678-1-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
Message-ID: <20141015165452.GB15770@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 09, 2014 at 09:06:22PM +0200, Johan Hovold wrote:
> This series fixes a few issues with the omap rtc-driver, cleans up a bit
> and finally adds support for the PMIC control feature found in some
> revisions of this RTC IP block.
> 
> Ultimately, this allows for powering off the Beaglebone and waking it up
> again on RTC alarms.
> 
> I noticed yesterday that Lokesh Vutla recently posted some patches to
> add regulator support to this driver. [1] While that series has some
> issues that needs to be addressed, I still think it could be a good idea
> to rebase my pmic_power_en patch on top of it as it adds some long
> overdue device abstraction. That would be needed anyway in order to
> support the new power-off infrastructure that's in the pipe in a clean
> way. [2]
> 
> So my suggestion is to merge the first seven patches, rebase Lokesh
> series on top of that, and then I rebase my final five patches on top
> of that in turn. Hopefully, the new power-off handler call chain will
> have stabilised by then.

BTW, how do you test this series ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141015/80c03d36/attachment.sig>
