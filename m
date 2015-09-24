From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 24 Sep 2015 09:16:19 +0100
Subject: [PATCH 2/2] Convert smsc911x to use ACPI as well as DT
In-Reply-To: <56033C10.2040708@linaro.org>
References: <1439417187-21411-1-git-send-email-jeremy.linton@arm.com>
 <1439417187-21411-3-git-send-email-jeremy.linton@arm.com>
 <1443033714.74600.18.camel@infradead.org> <560310EA.2070805@intel.com>
 <1443042212.74600.30.camel@infradead.org> <56033C10.2040708@linaro.org>
Message-ID: <1443082579.74600.48.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-09-23 at 16:56 -0700, Hanjun Guo wrote:
> 
> It really depends on the people who writing the ASL code (DSDT),
> I'm not sure if Windows will use _DSD and how to use it, but
> firmware guys may just use the device ID to make the firmware
> to be usable both by Linux and Windows, and that's reasonable
> I think.

And the ideal way to do that is to add a _CID of "PRP0001" and a
compatible string, and then Linux doesn't need to care about the
special new HID that you've added purely to pander to the limitations
of Windows.

That way, once drivers are converted from the legacy of-property APIs
to the new device-property APIs, there should be *nothing* required to
make device drivers work under ACPI. That was kind of the point.

If people want to add HIDs, fine. But let's not go down a path which
*requires* modifying drivers.

(I'm planning to try to learn Coccinelle and do a bombing run convertin
to the new API some time soon, FWIW).

-- 
dwmw2

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5691 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150924/287573da/attachment.bin>
