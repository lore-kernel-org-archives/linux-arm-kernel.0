From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Fri, 26 Sep 2014 22:47:40 +0200
Subject: [PATCH v3 11/12] mmc: sunxi: Convert MMC driver to the standard
 clock phase API
In-Reply-To: <20140926150204.GT15315@lukather>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
 <3992138.y6J8TjIuMq@pagira.o2s.ch> <20140926150204.GT15315@lukather>
Message-ID: <16423025.s6ZiXuohCJ@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
Great! Since I didn't see any mistakes from my side it shouldn't be a problem.
Because someone has borrowed my UART2USB(FT232)-cable I unfortunately can't
test the code for now.
If you can verfiy that all the adaptions are working properly on A10/A20 and
all the others you my assume my:
	Acked-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>

chears and all the best
david

> > > [...]
> > How did you calculate the actual phase values from the original
> > parameters?
>
> Like shown in the clock driver. 0 is always a 180 deg phase shift, and
> any other value is the number of the parent clock cycle to outphase
> the clock of.
> 
> the clock out phase is calculating using:
> 
> phase = 360 * interval / period.
> 
> with period = 1 / (parent_freq / divider)
> and interval = reg / parent_freq
> 
> which makes
> 
> phase = 360 * (reg / parent_freq) * (parent_freq / divider)
> 
> If we simplify by removing the parent_freq, we end up with
> 
> phase = 360 * reg / divider, which makes it rather trivial to
> calculate.
> 
> Maxime

-- 
David Lanzend?rfer
OpenSourceSupport GmbH
System engineer and supporter
http://www.o2s.ch/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140926/074b17e2/attachment.sig>
