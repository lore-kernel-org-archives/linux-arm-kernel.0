From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 4 Oct 2018 09:20:53 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.20, part 3
In-Reply-To: <CAK8P3a2BjnCZQiR8qRE--=RHTaFw2kB-Jz=g0A0KvGpaaWY3DA@mail.gmail.com>
References: <1538490605-26653-1-git-send-email-dinguyen@kernel.org>
 <CAK8P3a2BjnCZQiR8qRE--=RHTaFw2kB-Jz=g0A0KvGpaaWY3DA@mail.gmail.com>
Message-ID: <2db3b052-eb2f-1411-f2d3-602a1327174a@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 10/04/2018 09:12 AM, Arnd Bergmann wrote:
> On Tue, Oct 2, 2018 at 4:30 PM Dinh Nguyen <dinguyen@kernel.org> wrote:
> 
>> Dinh Nguyen (1):
>>       arm64: dts: stratix10: add ethernet aliases
> 
> This one doesn't look quite right: you are adding the aliases in the .dtsi
> files, which might be shared by multiple .dts files. There is no guarantee
> that each board uses all three ethernet ports in the chip, even when all
> boards we support in the kernel do.
> 

I kinda thought it would make sense to have all the ethernet aliases in
the dtsi file because even if different boards do not use all the
ethernets ports, the unused ethernet ports would be left disabled from
the dtsi file.

But then some boards may just use gmac1 or gmac2 instead of gmac0. So
yes, I'll move the aliases to the specific board file.

Thanks,
Dinh
