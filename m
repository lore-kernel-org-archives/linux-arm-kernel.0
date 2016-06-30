From: kvalo@codeaurora.org (Kalle Valo)
Date: Thu, 30 Jun 2016 11:46:10 +0300
Subject: [linux-sunxi] Re: [PATCH 1/4] brcmfmac: Add brcm,
 nvram_file_name dt property
In-Reply-To: <f8995599-115d-87e5-7928-c029b48584f1@broadcom.com> (Arend Van
 Spriel's message of "Wed, 29 Jun 2016 20:51:44 +0200")
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <CAOiHx=n6itfmvwYQh+jUSDNguQFkos=MzjkDWP=GsupdgvF6KQ@mail.gmail.com>
 <b49a9e4b-d591-d978-8005-413f39ebf2bd@redhat.com>
 <871t3gdj6p.fsf@purkki.adurom.net>
 <ea10ff70-26e6-e151-5cea-c54bd12a054c@redhat.com>
 <f8995599-115d-87e5-7928-c029b48584f1@broadcom.com>
Message-ID: <87mvm36p4d.fsf@kamboji.qca.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

>> Since we are dealing with a per-board config-file here, which is
>> loaded from the os filesystem we really need to specify a basename
>> here as the list of possible boards is endless, so we cannot
>> have a lookup table in the driver.
>
> As Jonas mentioned the general principle of device tree is to be
> agnostic with regards to OS and/or driver as you undoubtedly know. His
> proposal seems like a usable solution for your problem while complying
> to the device tree principle. So instead of overriding the default
> brcmfmac should modify it when dt specifies the "module" property, ie:
>
> no "module" in DT:	nvram filename = brcm/brcmfmac43362-sdio.txt
> "module=ap6210" in DT:	nvram filename = brcm/brcmfmac43362-ap6210.txt

Just out of curiosity, what does "ap6210" exactly mean? I get that 43362
is the chip id, but not ap6210. Is it just an arbitrary name?

-- 
Kalle Valo
