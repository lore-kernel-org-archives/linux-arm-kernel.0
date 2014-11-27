From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Thu, 27 Nov 2014 15:34:15 +0000
Subject: [PATCH v3 5/5] tty/serial: Add Spreadtrum sc9836-uart driver
 support
In-Reply-To: <CAAfSe-uWvn4MX-+GKuvvd=G2MTfLDCFeLRoUGWp7vvc81wfu0w@mail.gmail.com>
References: <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <54761BFC.4020705@ti.com>
 <CAAfSe-uMqy7zwiEK+nDoMPw_oni8L_vq7oW2Me5AY8z8KGpjwQ@mail.gmail.com>
 <3400511.2SONqVcoEr@wuerfel>
 <CAAfSe-uWvn4MX-+GKuvvd=G2MTfLDCFeLRoUGWp7vvc81wfu0w@mail.gmail.com>
Message-ID: <20141127153415.3c2817b5@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Yes, I saw this way in other serial drivers.
> But, if then, there are two questions for me:
> 1. Why did some serial drivers need an UN_SHARED irq?
> 2. How can we choose a right way?

If your hardware can support sharing an IRQ then shared is the right way
- along with the test Arnd suggested. Some hardware lacks the needed
facilities to handle shared interrupt.


Alan
