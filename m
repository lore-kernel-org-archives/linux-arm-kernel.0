From: eric@anholt.net (Eric Anholt)
Date: Thu, 09 Jun 2016 17:16:11 -0700
Subject: [PATCH v2 1/9] pinctrl: walk into bcm subdir unconditionally
In-Reply-To: <CACRpkdZKii2QR2TWYZdG-cdTn2UeVDcE3d39xPffWwipHcthpg@mail.gmail.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <1464934708-24769-2-git-send-email-kraxel@redhat.com>
 <CACRpkdZKii2QR2TWYZdG-cdTn2UeVDcE3d39xPffWwipHcthpg@mail.gmail.com>
Message-ID: <87mvmtx5is.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij <linus.walleij@linaro.org> writes:

> On Fri, Jun 3, 2016 at 8:18 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>> There is no ARCH_BCM on arm64, and we need pinctrl-bcm2835 for the rpi3.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> ---
>>  drivers/pinctrl/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
>> index e4bc115..88586c0 100644
>> --- a/drivers/pinctrl/Makefile
>> +++ b/drivers/pinctrl/Makefile
>> @@ -35,7 +35,7 @@ obj-$(CONFIG_PINCTRL_TB10X)   += pinctrl-tb10x.o
>>  obj-$(CONFIG_PINCTRL_ST)       += pinctrl-st.o
>>  obj-$(CONFIG_PINCTRL_ZYNQ)     += pinctrl-zynq.o
>>
>> -obj-$(CONFIG_ARCH_BCM)         += bcm/
>> +obj-y                          += bcm/
>
> Looks OK to me, but would like Stephen's or Eric's ACK?

It looks like this is the only instance of filtering the directory on
CONFIG_ARCH_BCM, so regardless of the patch 4 resolution,

Acked-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/bf187f9a/attachment.sig>
