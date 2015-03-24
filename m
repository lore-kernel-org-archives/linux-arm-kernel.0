From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Mar 2015 23:25:52 +0000
Subject: [PATCH] ARM: force linker to use PIC veneers
In-Reply-To: <CAKv+Gu9pNZFjrRbRkK=Yp5RkV6GCM2NmVWzXRYmqmS97q+e0NQ@mail.gmail.com>
References: <1427192184-31261-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150324122239.GB3579@e103592.cambridge.arm.com>
 <CAKv+Gu-MpvAnkEd2L_OPGpDv5cnCZACvzuQ9LbG8O5kjDRQUwQ@mail.gmail.com>
 <alpine.LFD.2.11.1503241112420.27567@knanqh.ubzr>
 <CAKv+Gu_kLtCqM1FtFRQdyBkzT3Rdqx90zcPFdtovnGOFf=d+3g@mail.gmail.com>
 <alpine.LFD.2.11.1503241125450.27567@knanqh.ubzr>
 <CAKv+Gu9pNZFjrRbRkK=Yp5RkV6GCM2NmVWzXRYmqmS97q+e0NQ@mail.gmail.com>
Message-ID: <20150324232552.GW8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 24, 2015 at 04:51:07PM +0100, Ard Biesheuvel wrote:
> Yes, there are still some instances left of that, including the core
> cpu_resume() itself.
> (and they all copy the same comment :-))

That's because I follow the ethos of "why write complex code when
simple and obvious code will do" and we'd done this for the original
SA11x0 CPU resume code which formed (to some extent) the basis of the
consolidated version we have today.

At the time cpu_resume() was consolidated (which is actually only in
the last five years or so) there wasn't the requirement to have large
kernels link, so rewriting it as relatively complex implementation
would've been damned stupid and a needless change in the consolidation
effort.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
