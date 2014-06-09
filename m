From: robherring2@gmail.com (Rob Herring)
Date: Mon, 9 Jun 2014 18:18:59 -0500
Subject: [PATCH v2 3/7] tty/serial: convert 8250 to generic earlycon
In-Reply-To: <CA+8MBbKE1E2uq9LefiDAV9hv2Z8OTkjx9mkXjE6_--F_emRC8A@mail.gmail.com>
References: <1397859600-11507-1-git-send-email-robherring2@gmail.com>
 <1397859600-11507-4-git-send-email-robherring2@gmail.com>
 <CAE9FiQVrwypK4u5yTCt-AxMuBnOn7jv=V3d4Zb3cd9JDNEUVPw@mail.gmail.com>
 <CAL_JsqKux+BTHeYo6XEzzQMAFJZHVjbURM973oHT=t698GbJbA@mail.gmail.com>
 <20140503220731.GA10927@kroah.com>
 <20140503221658.GA13403@kroah.com>
 <CA+8MBb+7f1bOnJjJWj1vxa0UNuQwz7OGRDR_QFTxOT=9cynabQ@mail.gmail.com>
 <CA+8MBbKE1E2uq9LefiDAV9hv2Z8OTkjx9mkXjE6_--F_emRC8A@mail.gmail.com>
Message-ID: <CAL_JsqKvoO9acX==-LdD6boO=B3xr=ijra_G0uqRZGzACZZUJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 9, 2014 at 5:35 PM, Tony Luck <tony.luck@gmail.com> wrote:
> On Mon, Jun 9, 2014 at 3:25 PM, Tony Luck <tony.luck@gmail.com> wrote:
>> Linus' tree (HEAD=963649d735c8) is spitting out all sorts of garbage
>> on the serial console - as if the baud rate is being periodically set
>> to something weird, and then back to 112500.  I see over a dozen
>> blocks of junk interspersed with good output.
>
> Ah - it seems that I need to be more specific on the cmdline
>
>      console=uart8250,io,0x3f8,115200
>
> makes all the garbage disappear.
>
> Do I need to update: Documentation/ia64/serial.txt
> which has the example of "console=uart,io,0x3f8"?

It should do auto detect of the baud-rate if it is not specified which
for 8250 is just reading the baud-rate divider and calculating the
baud-rate using the uart clock. It should just reprogram the divider
with the same divider value. I don't see anything obvious why this
would have broken.

Rob
