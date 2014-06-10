From: tony.luck@gmail.com (Tony Luck)
Date: Tue, 10 Jun 2014 13:52:08 -0700
Subject: [PATCH v2 3/7] tty/serial: convert 8250 to generic earlycon
In-Reply-To: <CAL_JsqKvoO9acX==-LdD6boO=B3xr=ijra_G0uqRZGzACZZUJg@mail.gmail.com>
References: <1397859600-11507-1-git-send-email-robherring2@gmail.com>
 <1397859600-11507-4-git-send-email-robherring2@gmail.com>
 <CAE9FiQVrwypK4u5yTCt-AxMuBnOn7jv=V3d4Zb3cd9JDNEUVPw@mail.gmail.com>
 <CAL_JsqKux+BTHeYo6XEzzQMAFJZHVjbURM973oHT=t698GbJbA@mail.gmail.com>
 <20140503220731.GA10927@kroah.com>
 <20140503221658.GA13403@kroah.com>
 <CA+8MBb+7f1bOnJjJWj1vxa0UNuQwz7OGRDR_QFTxOT=9cynabQ@mail.gmail.com>
 <CA+8MBbKE1E2uq9LefiDAV9hv2Z8OTkjx9mkXjE6_--F_emRC8A@mail.gmail.com>
 <CAL_JsqKvoO9acX==-LdD6boO=B3xr=ijra_G0uqRZGzACZZUJg@mail.gmail.com>
Message-ID: <CA+8MBbLooWm9xys+gYa5uL1eVTH-qzaR+RaZgsrqV-8XkqGadQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 9, 2014 at 4:18 PM, Rob Herring <robherring2@gmail.com> wrote:
> It should do auto detect of the baud-rate if it is not specified which
> for 8250 is just reading the baud-rate divider and calculating the
> baud-rate using the uart clock. It should just reprogram the divider
> with the same divider value. I don't see anything obvious why this
> would have broken.

Something very weird is happening.  Output is good so long as I put the
trailing ",115200" on the command line.

But I made early_serial8250_setup() printk() the return value it got
from probe_baud() - in case is was somehow getting 115201 or some
other silly value ... nope. Exactly 115200.

I also can't explain why the "noise" comes and goes a dozen
times during boot,

Does some other place in the kernel look at the "uart..." command
line argument?

-Tony
