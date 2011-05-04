From: green@linuxhacker.ru (Oleg Drokin)
Date: Wed, 4 May 2011 11:54:28 -0400
Subject: [PATCH 3/4] omap: move detection of NAND CS to
	common-board-devices
In-Reply-To: <4DC0F469.9030406@compulab.co.il>
References: <cover.1303682352.git.mike@compulab.co.il>
	<e2d77d1e885e6878ffbc9bf9dcf0b2dbea2b5d1f.1303682352.git.mike@compulab.co.il>
	<724FD998-C5DC-4C36-911B-52037F6D4323@linuxhacker.ru>
	<44342B2F-34C0-490C-91B8-96A9EA683F9B@linuxhacker.ru>
	<4DC0F469.9030406@compulab.co.il>
Message-ID: <217399A1-383F-4F69-B9D1-0421A48481C8@linuxhacker.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On May 4, 2011, at 2:38 AM, Mike Rapoport wrote:

> On 05/04/11 07:10, Oleg Drokin wrote:
>> Ok, so here's a simple patch to save everyone trouble, I guess.
>> 
>> Though on the other hand I can imagine that perhaps including this generic common-board-devices.c
>> might not be desirable for people that don't use anything from that file.
> Since the common-board-devices.c has TWL initialization I doubt there would a
> board that does not use it at all...

Actually the twl init you have is somewhat inflexible.
E.g. on the Nook Color the 1st i2c bus has the twl and some other devices, but I don't see how
to put more than just the twl on the first bus with your common code.

Bye,
    Oleg
