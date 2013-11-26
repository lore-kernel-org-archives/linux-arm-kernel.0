From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Nov 2013 13:43:40 +0100
Subject: ACPI
In-Reply-To: <20131125154110.GB3243@srcf.ucam.org>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com>
 <CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com>
 <CACRpkdaCXJzWXoesjD3Jqpm4XMHLQp3SsHcsDG3veUS+xarqHQ@mail.gmail.com>
 <CACxGe6vUKzow7QpeX2mU7CiZQzY8aZ+p0jd8Vk0+dqz0B=D0Ew@mail.gmail.com>
 <20131125154110.GB3243@srcf.ucam.org>
Message-ID: <CACRpkdY+6dzs8MpKKtW-3kzsLkZjsit9SeN20k_33TAtVf3NEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 4:41 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> In the past ACPI implementations handled GPIO by providing
> methods that accessed hardware registers directly. I've seen DSDTs that
> implement i2c entirely in ASL.

Is that common?

Since i2c is a slow bus, can be 100kHz or so, how does that
avoid locking the entire CPU while e.g. waiting for transactions on
the external bus to complete?

In I2C drivers we typically use completion IRQs so that we can
do other stuff when the I2C traffic is busy ...

I have a feeling we should not recommend ARM implementers
to go and do things like this.

Yours,
Linus Walleij
