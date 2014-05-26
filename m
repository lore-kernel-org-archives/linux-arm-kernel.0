From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 26 May 2014 10:07:45 +0200
Subject: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
In-Reply-To: <CAGb2v64Siixnds9fXGWfTotjq0zGmeqNa-52FNNOcbxFcCjkCg@mail.gmail.com>
References: <537DC832.3020006@redhat.com>
 <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com>
 <537DE1AA.5050606@redhat.com> <537E31F7.1030505@gmail.com>
 <537F1148.3010102@redhat.com> <20140523112239.GB12304@sirena.org.uk>
 <537F3610.3050104@redhat.com> <20140523162718.GE22111@sirena.org.uk>
 <53806F26.6050706@redhat.com> <20140525123452.GS22111@sirena.org.uk>
 <53824294.1090609@redhat.com> <5382F276.8090305@broadcom.com>
 <CAGb2v64Siixnds9fXGWfTotjq0zGmeqNa-52FNNOcbxFcCjkCg@mail.gmail.com>
Message-ID: <5382F651.9010506@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/26/2014 09:59 AM, Chen-Yu Tsai wrote:
> On Mon, May 26, 2014 at 3:51 PM, Arend van Spriel <arend@broadcom.com> wrote:
>> + Russell

<snip>

>> Hi Hans,
>>
>> I recalled a recent patchset from Russell King. He was working on i.MX6
>> platform with brcmfmac device and ended reworking sdhci/mmc host controller
>> code in a series of patches [1]. Patch 34 might be similar to what you are
>> trying to accomplish.
> 
> I believe that is a resend of Olof's patch I mentioned early in this
> discussion. :)

Ok, assuming that is the case, then it seems to me that we are all moving
somewhat in the same direction, which is good :)

What I would like to propose is to move forward with Olof's patch with
2 changes made to it:

1) Store the clocks / resets / whatever in childnodes of the mmc host node,
with the childnodes using the addressing scheme described in the patch
from Sascha Hauer titled: "mmc: Add SDIO function devicetree subnode parsing",
as this is where they really belong (and in some cases the sdio function driver
may need access to them too).

2) Make Olof's code only do the powerup if the child node has a compatible of
"simple-sdio-powerup", to avoid it getting in the way of more complex poweron
scenarios (which may require a separate pmic driver or some such) later.

Regards,

Hans
