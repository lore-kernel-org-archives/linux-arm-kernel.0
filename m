From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 5 Sep 2018 11:40:49 +0200
Subject: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
In-Reply-To: <bf917897-1697-a6c4-7f77-8dfa74dddc8a@broadcom.com>
References: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
 <CAOesGMhjcJ1p3QcEYb9fsx3fMXAOsgR2njOq=VKgEbWGwJi36g@mail.gmail.com>
 <fb07b89d-d427-5e59-9f17-b12df26284ec@broadcom.com>
 <CAKv+Gu-R7eX=aj=O2-gpzmp0K4t0T4s536UiqJZs0WuxRjkYwQ@mail.gmail.com>
 <CAOesGMho8CfT7iDXadmkB5=7DoOi6n8qXcS9X643vf+Y0BbD6w@mail.gmail.com>
 <CAKv+Gu_mKU+RdPgg2Dfezy4-L+KDEEBx02R49ObomRhEkJJ6Mw@mail.gmail.com>
 <CAOesGMgLHx3+j1bWEsMWsN-yjGNZyLOpAjLg0Jut8gG=ADE25g@mail.gmail.com>
 <CAKv+Gu_x=bS4xJcD_LuEnnN=Lx4Jc87uK8J_ACdA9EeUqtM3Yg@mail.gmail.com>
 <CACxGe6uK+N5XUqZhH7gAQXoq+QXMvFPHF_i4WqivrufTU=0cog@mail.gmail.com>
 <bf917897-1697-a6c4-7f77-8dfa74dddc8a@broadcom.com>
Message-ID: <CAKv+Gu8FK9K0G-GJygdpkwqKYzjvpDDj8TyGTC2u0SRxK3ez_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 September 2018 at 19:19, Scott Branden <scott.branden@broadcom.com> wrote:
>
> Rather than introduce EFI_ARMSTUB_DTB_LOADER, why not have
> the efistub use CONFIG_OF to determine whether it supports dtb= or not?
>
> That way ACPI-only distros disable devicetree support entirely.
>

Unfortunately, CONFIG_OF cannot be disabled on arm64 even on ACPI-only builds.
