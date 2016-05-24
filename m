From: khiem.nguyen.xt@rvc.renesas.com (Khiem Nguyen)
Date: Tue, 24 May 2016 14:29:28 +0700
Subject: [PATCH v2 1/3] arm64: dts: r8a7796: Add Renesas R8A7796 SoC
 support
In-Reply-To: <CAMuHMdV+atFKJjxcH7RkBCdabsBqk5Y3TTHCPN+sprDaM1xj_w@mail.gmail.com>
References: <1463966906-15129-1-git-send-email-horms+renesas@verge.net.au>
 <1463966906-15129-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXsu=O13rLysob1Xp+5vWcp7gq6byCffR-6hGc+W-837A@mail.gmail.com>
 <5742B66C.7080102@rvc.renesas.com>
 <CAMuHMdV+atFKJjxcH7RkBCdabsBqk5Y3TTHCPN+sprDaM1xj_w@mail.gmail.com>
Message-ID: <574402D8.6030400@rvc.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On 5/24/2016 1:35 PM, Geert Uytterhoeven wrote:
> Hi Khiem,
>
> On Mon, May 23, 2016 at 9:51 AM, Khiem Nguyen
> <khiem.nguyen.xt@rvc.renesas.com> wrote:
>> Using 1.0 will open Suspend-to-RAM support if secure firmware supports that
>> feature.
>> However, we might need additional work in drivers to support suspend/resume
>> handlers.
>> So, I suggest that we keep using 0.2 until Suspend-to-RAM feature is
>> confirmed in r8a7795/r8a7796.
>
> Note that we do have suspend/resume support on R-Car Gen2, albeit some
> drivers may lack code to save/restore state when their devices are powered
> down, as R-Car Gen2 doesn't have power domains for devices.
>
> So I'd expect everything to work fine, as long as no R-Car Gen3-specific
> drivers or devices residing in multimedia power domains are involved.

In my test environment using latest integration branch in 
renesas-drivers (v4.6), it failed to resume due to operation inside 
rcar_du_pm_resume().
Probably, it should be fixed soon.

FYI, your secure firmware will have Suspend-to-RAM support if below log 
is output.
    psci: PSCIv1.0 detected in firmware.

Thanks.

Best regards,
KHIEM Nguyen
