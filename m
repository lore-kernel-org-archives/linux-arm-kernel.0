From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Apr 2015 11:03:31 +0200
Subject: [PATCH 1/5] MFD/OF: document MFD devices and handle simple-mfd
In-Reply-To: <20150328134157.000A3C40AE0@trevor.secretlab.ca>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
 <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
 <20150328134157.000A3C40AE0@trevor.secretlab.ca>
Message-ID: <CACRpkdYC_xG90bqnsog_C67WfBi1bcwki1DeN_jozmu5RTW89w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 28, 2015 at 2:41 PM, Grant Likely <grant.likely@linaro.org> wrote:

> However, I think this is going to lead to a future problem. It solves
> the immediate case of getting an MFD device to be auto populated when
> the kernel doesn't need to immediately do something. However, I can
> forsee a situation where the device can be supported by simple-mfd, but
> at some point it is discovered that better features can be enabled if
> the mfd device has a proper driver.

For the general case where access to the MFD needs some mediation
or marshalling yes, I think this is theoretically possible.

For the most common MMIO case where the MFD devide is a syscon,
it is not so likely. Or rather extremelt unlikely.

We could restrict the use cases to strictly syscon/MMIO MFD devices
but it would just be a documentation fix.

Yours,
Linus Walleij
