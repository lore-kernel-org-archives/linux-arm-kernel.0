From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 21 Feb 2013 11:57:15 -0600
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin function
 name
In-Reply-To: <CAKGA1bn22xctSj_33HQsWwnVB=RO2OJ=eYvgRD-kF+PiQcnC4Q@mail.gmail.com>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
 <51251A11.2030300@wwwdotorg.org>
 <CAKGA1bkHH1XC38_VM=QhDrr33uqqSbwe0n+GfXEPs43K_Do=CQ@mail.gmail.com>
 <20130221050247.GD17738@S2101-09.ap.freescale.net>
 <CAKGA1bn22xctSj_33HQsWwnVB=RO2OJ=eYvgRD-kF+PiQcnC4Q@mail.gmail.com>
Message-ID: <CAKGA1bmf3HXGcEYkw2Gk-uS40=r_ZX-=Dh4G3GGSSwz8HiLqNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I feel like I should be more concise, so here are what I would
consider MY goals for iomux definition on Freescale processors;

Freescale provide spreadsheets, GUI tools and XML and C header output
for the iomux model.

If you can't copy it right from the documentation or a script or
program (C, Python, whatever) any of the above into a device tree
without first encoding or parsing the binding in a suitable format for
the program, then the binding is not desirable - for me, at least. If
we can't go back to the original data from BSP kernels and port it to
new device trees without a 3-step cross-reference and a preprocessing
step for verification, you are adding items to my in tray...

Usually it's spit out from the IOMUX tool as XML and example C source
(with certain definitions) with header files for the chip so you can
drop it right into your bringup tool, bootloader, OS or whatever.
Using that as a reference worked fine - it's register offsets
(absolute from IOMUX tool), values. Copy pasting from the spreadsheet
worked fine. Printing out the docs page and marking the bits worked
fine. You're now telling me with this patchset that I have to have
another documentation source and additionally verify that it even
applies to the board by comparing it to all of the above.

Therefore, nack :D

Either use the preprocessor to really verify the data, but don't use
it just to turn 5 values into a string literal.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
