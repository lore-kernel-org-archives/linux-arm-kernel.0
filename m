From: adrienverge@gmail.com (=?UTF-8?Q?Adrien_Verg=C3=A9?=)
Date: Wed, 4 Dec 2013 22:49:25 -0500
Subject: [PATCH 0/3] ARM Coresight: Enhance ETM tracing control
In-Reply-To: <20131204230239.GB9205@kroah.com>
References: <CANsc=4VRLWhaVA15HrBEeM+FJC0tS+b5KKopDb7bP8nxzR8=zA@mail.gmail.com>
 <20131204070442.GA31665@kroah.com>
 <CANsc=4UHEG5cmg9SD3r3rsuJnM9zqq2WiTQdUwrYFr_kkbsVvg@mail.gmail.com>
 <20131204170703.GA14859@kroah.com>
 <CANsc=4X7ThCvgz9bfu1ZZg9FCti5SMdbXL5tA584z-oZ_HEByg@mail.gmail.com>
 <20131204230239.GB9205@kroah.com>
Message-ID: <CANsc=4UGi5sMdUW5qQDzEJx4h8NDU+-b=xOLBAZtzbV5ugz3Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/12/4 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> How much overhead does the existing tracing code have on ARM?  Is ETM
> still even needed?  Why not just use ETM for the core tracing code
> instead?

Coresight ETM is not just faster than /sys/kernel/debug/tracing, it
provides more detailed and customisable info. For instance, you can
trace every load, store, instruction fetch, along with the number of
cycles taken, with almost zero-overhead.

> What's wrong with the in-kernel tracing logic that you can't use that
> instead of the ETM stuff?

ETM has a different purpose. Integrating it in
/sys/kernel/debug/tracing would not take advantage of all its
features.
