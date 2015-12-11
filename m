From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Dec 2015 09:28:54 +0100
Subject: [PATCH 2/2] ARM: mvebu: kirkwood: add PogoPlug series 4 device
 tree
In-Reply-To: <20151127202738.GC32356@lunn.ch>
References: <1448578868-6323-1-git-send-email-linus.walleij@linaro.org>
 <20151127202738.GC32356@lunn.ch>
Message-ID: <CACRpkdYHk4ZtF-UY7tp9YrGocyqKNCCPLfWheeP4wvAVxJzhHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 9:27 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> +     chosen {
>> +             bootargs = "console=ttyS0,115200n8";
>> +             stdout-path = &uart0;
>
> Hi Linus
>
> You can append the baud rate etc to uart0, and then don't need
> bootargs.

I dropped the bootargs but how do you see it here?

Of course I can do this, so that is what I did:

&uart0 {
    status = "okay";
    current-speed = <115200>;
};

But that only indicates that the hardware (firmware) set up the
port to a speed like that. It wouldn't work if the hardware was
set any other way. It seems to be like so on the PogoPlug though
so I went with this.

It has no way to indicate how parity etc was set up on the UART
though.

However there is also stdout-path, so I went for this:

stdout-path = "serial0:115200n8";

Reposting the patch soon.

Yours,
Linus Walleij
