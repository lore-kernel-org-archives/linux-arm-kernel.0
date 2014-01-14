From: nm@ti.com (Nishanth Menon)
Date: Tue, 14 Jan 2014 15:13:24 -0600
Subject: [PATCH] ARM: OMAP4: sleep: byteswap data for big-endian
In-Reply-To: <52D5A60C.7080800@ti.com>
References: <1389625399-24087-1-git-send-email-taras.kondratiuk@linaro.org>
 <52D404DE.2020806@ti.com>
 <CAArO44samX_uMeC93w4DBbC+yskEmrvVt_i-5VV_seatM56ypw@mail.gmail.com>
 <52D55CE5.1060902@ti.com>
 <CAA3XUr2cnF_rxMYvZfjBx22Sa8YE45o_qUU8GNoerQwhWqxhNQ@mail.gmail.com>
 <CAGo_u6oKpRFnPAWaqr9NTNAJB+m56jiDgBUgvsiZpaQ-3SF2kw@mail.gmail.com>
 <CAA3XUr1_cNuPmMU6Fs6c7Si2So0VFGcLyGJe+tS_R47BVKRXnw@mail.gmail.com>
 <CAGo_u6p7ErrKOMy4Ljg3nehVpd=DOg3XDn6gZ1nrFE_OuOjsWg@mail.gmail.com>
 <52D5A60C.7080800@ti.com>
Message-ID: <CAGo_u6oGDK5s0SeE6Z7UFM6eYdgoy-E+Tj67+pBWP-wQ3r9=QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 3:03 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>
>> ok.. some sort of Linaro thing about which I have no background about
>> - but dont really care in this context.
>>
> Nothing related Linaro. Its just that platforms are supporting ARM BE
> mode and Linaro folks had working patches for Panda. So I suggested
> to get them on the lists.

I tend to think -> is this with OFF mode and CPUidle completely
working? All context save and restore works with this? on HS and GP
devices with BE mode builds? works on SDP4430,60 variations,
considered reuse with AM43xx which could use parts of that logic?

I mean to indicate that terms like "works on panda" tends always to be relative.

It is nice to see it as a proof of concept, but I'd hate to see some
dead code lying around in kernel and folks blindly following suit and
introducing macros for new assembly for a feature that in practice
just one group of folks care about and creates additional burden for
rest of folks trying to keep that functionality going as we jump from
one "device tree" style churn to another "framework"? Not to mean that
good features should be kept away.. but personally, I could not find
convincing arguments in this case..

Regards,
Nishanth Menon
