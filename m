From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 22 Oct 2015 17:42:44 +0200
Subject: [PATCH v4 0/5] mtd: pxa3xx_nand: rework the timing setup
In-Reply-To: <CAAEAJfCmo5u6=5GN6+k8GsFhC0dg477gVYY+t77uODP-PgWLGw@mail.gmail.com>
References: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
 <20151022171259.57581575@free-electrons.com>
 <CAAEAJfCmo5u6=5GN6+k8GsFhC0dg477gVYY+t77uODP-PgWLGw@mail.gmail.com>
Message-ID: <20151022174244.61eaf79e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Thu, 22 Oct 2015 12:22:24 -0300, Ezequiel Garcia wrote:

> Could you compare NAND throughput using keep-config (keeping
> the bootloader timings) and without keep-config (with ONFI timings) ?

Seems like we are within the measurement noise. I did each test only
once, and the test lasts only a few seconds, but here are the results:

Without keep-config (i.e ONFI timings) :

# time dd if=/dev/mtd3 of=/dev/null bs=1M
32+0 records in
32+0 records out
real	0m 3.54s
user	0m 0.00s
sys	0m 0.26s

With keep-config (i.e bootloader timings)

# time dd if=/dev/mtd3 of=/dev/null bs=1M
32+0 records in
32+0 records out
real	0m 3.77s
user	0m 0.00s
sys	0m 0.21s

I.e we are apparently slightly faster with the ONFI timings. However
again, the test duration is very short, and I didn't repeat the test
several times.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
