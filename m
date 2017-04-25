From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 25 Apr 2017 10:07:38 +0200
Subject: [PATCH RFC 0/5] *** SPI Slave mode support ***
In-Reply-To: <58FF0127.7070703@mentor.com>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
 <20170413125929.dygodgj6c35ydh5p@sirena.org.uk>
 <CAMuHMdUm=90ddNWM5KWqT+W0hqZ-QO6vPHj5OisbYquDYq1ZmA@mail.gmail.com>
 <58F06092.9080409@mentor.com>
 <CAMuHMdXa_O6RsqUciiNWQ0Zp6dniS47AUmPN9UWAWitP0csx=Q@mail.gmail.com>
 <58FDF430.5090306@mentor.com>
 <CAMuHMdVQS494-BAc-W-XOOLK8Xow85n+Cgih0FG+t4QxCFxhMA@mail.gmail.com>
 <58FF0127.7070703@mentor.com>
Message-ID: <20170425080738.cb6jaqvktgpir7zq@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jiada,

On Tue, Apr 25, 2017 at 12:56:23AM -0700, Jiada Wang wrote:
> the use case of
> "A (master) <=> B (slave)", "B (master) <=> C(slave)", do share MISO and
> MOSI lines,
> but there is no SS line between A and C. so for each SPI slave device, there
> is only one
> master device.

So you need a mutex to make A not use the bus while B communicates to C.
Otherwise you have two drivers on MOSI (A and B) and MISO (B and C).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
