From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 17 Jun 2013 14:55:50 +0530
Subject: [PATCH V2 01/10] USB: OHCI: Properly handle ohci-at91 suspend
In-Reply-To: <CAJFYCKG8i=33zXS-dhVJopaTVhCKJ_DCKo+q9wyx7CVzqzfn5g@mail.gmail.com>
References: <1371114989-2342-2-git-send-email-manjunath.goudar@linaro.org>
 <Pine.LNX.4.44L0.1306131513140.1561-100000@iolanthe.rowland.org>
 <CAJFYCKG8i=33zXS-dhVJopaTVhCKJ_DCKo+q9wyx7CVzqzfn5g@mail.gmail.com>
Message-ID: <CAKohpo=CJtzkbD5sf2==CKkEjez_x8L_5P66HVdBOW+WmCs5MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 June 2013 14:52, Manjunath Goudar <manjunath.goudar@linaro.org> wrote:
> when we are using tab characters  before "do_wakeup" and "ret" variable,we
> will be getting error below.
>
> WARNING: please, no space before tabs
> #31: FILE: drivers/usb/host/ohci-at91.c:622:
> +^Ibool ^I^Ido_wakeup = device_may_wakeup(&pdev->dev);$
>
> WARNING: please, no space before tabs
> #32: FILE: drivers/usb/host/ohci-at91.c:623:
> +^Iint ^I^Iret;$
>
> total: 0 errors, 2 warnings, 27 lines checked

That's because you are using both tabs and spaces to align. Just use
multiple tabs and remove all spaces.
