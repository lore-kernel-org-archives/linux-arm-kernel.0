From: jonas@microbit.se (Jonas Andersson)
Date: Tue, 24 Mar 2015 15:32:08 +0100
Subject: at91 clocks
Message-ID: <55117568.6090202@microbit.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I am working on a system with at91sam9260 soc. Trying to move from 
kernel 3.17.4 to 3.19.2. I have problem with pck1 clock.

In my old code i use clk_get() to get pck1 and pllb, set pllb as parent 
for pck1, set rate for pck1, enable pck1. Extract from 
/sys/kernel/debug/at91_clk:
pllb       users= 1 on   96000000 Hz main
pck1       users= 1 on   12000000 Hz pllb

In my new code i have defined the two clocks in DT:
         clocks = <&prog1>, <&pllb>;
         clock-names = "codec", "parent";
Extract from  /sys/kernel/debug/clk/clk_summary:
        mainck                             2            2 
18432000          0 0
           prog1                           1            1 
9216000          0 0
              pck1                         0            0 
9216000          0 0
           pllbck                          0            0 0          0 0
              usbck                        0            0 0          0 0
                 udpck                     0            0 0          0 0
                 uhpck                     0            0 0          0 0

I know i probably have to enable pck1 also.
But my main problem is that I got the wrong frequency and parent of prog1.
Why?

Thanks
  Jonas
