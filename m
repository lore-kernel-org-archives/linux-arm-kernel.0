From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 30 Sep 2011 14:46:44 +0200
Subject: S3C6410 synchronous mode
Message-ID: <2883074.1zzMvbgzlJ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

List,

I am working on porting mainline kernel for S3C6410-based Samsung phone
(Galaxy Spica GT-i5700). The SoC is mostly well documented, but some aspects
of it unfortunately are not. So I would like to ask some questions, especially
targetted at Samsung people.

SoC variant used in this phone seems to be operating in so called synchronous
mode, where both bus and ARM clocks are generated from the same PLL. I would be
interested in getting more information on this operating mode, especially how
it differs from asynchronous mode (except that ARM and buses run synchronously,
of course), what are performance aspects of both modes and whether synchronous
mode introduces some additional constraints to include, for example, in ARM
frequency scaling.

One more thing that I found is that the AHB bus is horribly slow, running at
133 MHz it maxes out at about 472 MB/s when using STM8 to write to uncached
memory and with STR it drops to 80 MB/s, while with STRB it really drops below
any reasonable level, to 20 MB/s. Might it be related to synchronous mode or
it is just a bug or feature of S3C6410?

Best regards,
Tom
