From: csd_b@daudt.org (Christian Daudt)
Date: Thu, 8 Aug 2013 15:56:37 -0700
Subject: [PATCH v2] ARM: DT: binding fixup to align with
 vendor-prefixes.txt
In-Reply-To: <1375482479-15732-1-git-send-email-csd@broadcom.com>
References: <1375482479-15732-1-git-send-email-csd@broadcom.com>
Message-ID: <CAGFynZ-mNRXKt8QxH4kBAUE0LB0r7sW1Lb4WcSe_DM4buSNd3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 2, 2013 at 3:27 PM, Christian Daudt <csd@broadcom.com> wrote:
> [ this is a follow-up to this discussion:
> http://archive.arm.linux.org.uk/lurker/message/20130730.230827.a1ceb12a.en.html ]
> This patchset renames all uses of "bcm," name bindings to
> "brcm," as they were done prior to knowing that brcm had
> already been standardized as Broadcom vendor prefix
> (in Documentation/devicetree/bindings/vendor-prefixes.txt).
> This will not cause any churn on devices because none of
> these bindings have made it into production yet.
> Also rename the the following dt binding docs that had "bcm,"
> in their name for consistency:
>  - bcm,kona-sdhci.txt -> kona-sdhci.txt
>  - bcm,kona-timer.txt -> kona-timer.txt
>
> Changes since v1:
>  - added driver match table entries for deprecated names
>
> Signed-off-by: Christian Daudt <csd@broadcom.com>
>

Hi,
 Any ACKs for this patch ? Alternatively, I can instead just patch
vendor-prefix to add "bcm" as an additional Broadcom prefix and just
stick to using bcm. I have told people internally to switch over to
brcm and there are patches for 3.12 that will be migrating to brcm but
I'd rather not have half bcm and half brcm and that will make things
quite confusing.

 Thanks,
   csd
