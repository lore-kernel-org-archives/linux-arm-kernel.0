From: olof@lixom.net (Olof Johansson)
Date: Thu, 3 Oct 2013 09:46:30 -0700
Subject: Use of drivers/platform and matching include?
In-Reply-To: <BC1C47B3-5412-4829-A1D9-AAB04694D1CC@codeaurora.org>
References: <BC1C47B3-5412-4829-A1D9-AAB04694D1CC@codeaurora.org>
Message-ID: <CAOesGMjJ6Uj0uGFJqtnWQyDW+tr6eLVWoHZ+B7uFna+L8N6E8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 3, 2013 at 7:45 AM, Kumar Gala <galak@codeaurora.org> wrote:
> As we look at upstreaming more support for the Qualcomm MSM SoCs there are a number of drivers or library like routines that are unique to the MSM platform, we are thinking that putting them under:
>
> drivers/platform/qcom/

drivers/platform has traditionally been used for OEM/product platform
drivers, i.e. stuff such as laptop drivers or server management module
drivers, i.e. not platforms in "SoC family" sense.

I don't have a good answer though. If it wasn't for the arm64 fork,
locating these under arch/arm somewhere would really be the reasonable
answer, like we used to do on powerpc. :(


-Olof
