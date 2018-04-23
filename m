From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 23 Apr 2018 19:35:46 +0200
Subject: brcm, cyw_bt: Add latest Cypress/Murata firmware
In-Reply-To: <CAD0U-hKMhgh9dgvBaEB66K_JomnkY82HDdtWu-tpYpNZw7mMMQ@mail.gmail.com>
References: <1524146649-25267-1-git-send-email-ryan.harkin@linaro.org>
 <CA+5PVA57X8aPXXLBTfaWxhULY7EgWooWy1NQoNq+X=vLWm2Q2g@mail.gmail.com>
 <7b9d1310-e850-2331-a11b-b22de8282797@redhat.com>
 <CAD0U-hKiK62Efg=kj3=-MOeeVA-4g0HW-6TW8Jo-YNuUs5LEQg@mail.gmail.com>
 <da653c17-ea3d-8c97-64f3-b7c6ce80dcf1@redhat.com>
 <CAD0U-hJ5ebJa0s+myT-qdEhwCVraHake8-z5u7CVeo1G3gGwjQ@mail.gmail.com>
 <09bc0fb5-4cbb-f4cd-32e5-40eaaa576b6b@redhat.com>
 <CAD0U-hKMhgh9dgvBaEB66K_JomnkY82HDdtWu-tpYpNZw7mMMQ@mail.gmail.com>
Message-ID: <85aa289a-4e11-403c-be01-f27d9a61f0bf@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23-04-18 19:17, Ryan Harkin wrote:
> 
> 
> On 23 April 2018 at 16:56, Hans de Goede <hdegoede at redhat.com <mailto:hdegoede@redhat.com>> wrote:

<snip>

>          ? ? As said before (sorry) NACK, we really must NOT distribute nvram
>          ? ? files under generic names.
> 
> 
>         That's fine. But I still think the generic files should be available in the repo for users who want to use them. Having them take an explicit step, like softlinking it to the board specific file, is fine by me. But I believe we should be able to get them if we wish to. At the very least, I would be interested in knowing how my board varies from the generic example given by Cypress/Murata/OEM.
> 
>         So how about we add the files but either in a sub-dir, and/or with example/generic/sample as the board name? Eg, we could push this file:
> 
>          ?? ? brcmfmac43430-sdio-generic.txt
> 
>         As you suggested, the code could look for?brcmfmac43430-sdio-<board name>.txt, if it doesn't find it, fall back to brcmfmac43430-sdio.txt. In this case, brcmfmac43430-sdio-generic.txt will never automatically load.
> 
> 
>     Putting them in linux-firmware as brcmfmac4xxxx-sdio-generic.txt /
>     brcmfmac4xxx-pci-generic.txt is fine.
> 
> 
> I've just started to re-work patch 2/3 and realised that there are already files like "brcmfmac43012-sdio.1LV.txt", where the 1LV is separated by '.' instead of "-", so I figured I'd leave those files as they are and only add ".generic" to the unlabelled/generic ones, unless you think I should add ".generic" to all of them?
> 
> Like this:
> 
> brcmfmac43012-sdio.1LV.txt
> brcmfmac43012-sdio-generic.txt -> brcmfmac43012-sdio.1LV.txt
> brcmfmac43340-sdio.1BW.txt
> brcmfmac43340-sdio.txt -> brcmfmac43340-sdio.1BW.txt
> brcmfmac43362-sdio.SN8000.txt
> brcmfmac43362-sdio.txt -> brcmfmac43362-sdio.SN8000.txt
> brcmfmac4339-sdio.1CK.txt
> brcmfmac4339-sdio-generic.txt -> brcmfmac4339-sdio.ZP.txt
> brcmfmac4339-sdio.ZP.txt
> brcmfmac43430-sdio.1DX.txt
> brcmfmac43430-sdio.1LN.txt -> brcmfmac43430-sdio.1DX.txt
> brcmfmac43430-sdio.txt -> brcmfmac43430-sdio.1DX.txt
> brcmfmac43455-sdio.1HK.txt
> brcmfmac43455-sdio.1LC.txt
> brcmfmac43455-sdio.1MW.txt
> brcmfmac43455-sdio-generic.txt -> brcmfmac43455-sdio.1MW.txt
> brcmfmac4354-sdio.1BB.txt
> brcmfmac4354-sdio.txt -> brcmfmac4354-sdio.1BB.txt
> brcmfmac4356-pcie.1CX.txt
> brcmfmac4356-pcie-generic.txt -> brcmfmac4356-pcie.1CX.txt

That is fine with me.

Regards,

Hans
