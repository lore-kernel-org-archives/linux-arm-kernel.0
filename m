From: jassisinghbrar@gmail.com (jassi brar)
Date: Mon, 26 Apr 2010 15:41:19 +0900
Subject: [PATCH 1/7] PL330: Add common core driver
In-Reply-To: <20100426045627.GI28105@trinity.fluff.org>
References: <1271834848-29179-1-git-send-email-jassisinghbrar@gmail.com>
	<j2x63386a3d1004231449ta90046b5pc29622b58a87b99a@mail.gmail.com>
	<n2y1b68c6791004231620lcd670271u3a9d33bb52c10e37@mail.gmail.com>
	<q2y63386a3d1004241859v8b31f756rb6ff9b4a7452ba@mail.gmail.com>
	<20100426045627.GI28105@trinity.fluff.org>
Message-ID: <q2q1b68c6791004252341k51da90d0xfaf2850b90d7c46c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 26, 2010 at 1:56 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> On Sun, Apr 25, 2010 at 03:59:26AM +0200, Linus Walleij wrote:
>> 2010/4/24 jassi brar <jassisinghbrar@gmail.com>:
>> > Btw, I think that driver should be divided in two files
>> > drivers/dma/api-pl330.c with common code and
>> > drivers/dma/<soc>-pl330.c for platform specific stuff like IRQ,
>> > registers base mapping and other quirks(if any). Any opinions?
>
> Possibly, but I think it may be better to pass these things via platform
> device for registers and irqs, and platform data for the quirks.
Some platforms implement just one i/f either secure or non-secure, others
might implement both. Having a separate file for platforms would make
it possible to switch between secure and non-secure i/fs acc to the needs
of the platform. Similarly for the DMAC reset mechanism.
Also, I am afraid, managing quirks in common code might get trickier over time.
