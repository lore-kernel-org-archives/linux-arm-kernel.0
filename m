From: lost.distance@yahoo.com (Paul Parsons)
Date: Sat, 10 Mar 2012 15:11:10 +0000 (GMT)
Subject: [PATCH v2] pxa/hx4700: Fix basic suspend/resume
In-Reply-To: <CA+gwMccn+rLo2Q+z+gxboE82pmGT0ud2c1Q65PzhrGhFXLrvgw@mail.gmail.com>
Message-ID: <1331392270.97238.YahooMailClassic@web29005.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

--- On Fri, 9/3/12, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> > Changed GPIO88, GPIO72, GPIO96 from KEEP_OUTPUT to
> DRIVE_HIGH.
> 
> The bq24022 GPIOs (72 and 96) should stay KEEP_OUTPUT to
> allow
> charging from the AC adapter while suspended.

I think I disabled this because I was wary of uncontrolled charging while
suspended. The SDG bootloader does have specific code to control charging
and the LEDs while suspended, but AFAIK it is not currently working.

Nonetheless, I've modified the patch.

Interestingly, the SDG bootloader seems to use LED interrupts to
periodically wake up during suspend. At last, that would explain why the
LED GPIOs are inputs, not outputs.

Paul
