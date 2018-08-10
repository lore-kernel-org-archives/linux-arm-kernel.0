From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 10 Aug 2018 16:57:11 +0100
Subject: [RFC net-next 00/15] net: A socket API for LoRa
In-Reply-To: <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
 <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
 <20180809125939.39ac2cc9@alans-desktop>
 <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
Message-ID: <20180810165711.59bf26f7@alans-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Except saving power, mitigating the wireless signal conflict on the
> air is one of the reasons.

If the device level is always receiving when not transmitting it has no
effect on this. The act of listening does not harm other traffic.

> The sleep/idle/stop mitigate the unconcerned RF signals or messages.

At the physical level it's irrelevant. If we are receiving then we might
hear more things we later discard. It's not running on a tiny
microcontroller so the extra CPU cycles are not going to kill us.

> > How do you plan to deal with routing if you've got multiple devices ?  
> 
> For LoRaWAN, it is a star topology.

No the question was much more how you plan to deal with it in the OS. If
for example I want to open a LORA connection to something, then there
needs to be a proper process to figure out where the target is and how to
get traffic to them.

I guess it's best phrased as

- What does a struct sockaddr_lora look like

- How does the kernel decide which interface it goes out of (if any), and
  if it loops back

remembering we might only be talking to a hub, or we might even be a
virtualized LORA interface where we are pretending to be some kind of
sensor and feeding it back.

Long term yes I think Alexander is right the inevitable fate of all
networks is to become a link layer in order to transmit IP frames 8)

Alan
