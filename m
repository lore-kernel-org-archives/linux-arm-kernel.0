From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 10 Dec 2009 19:37:04 +0100
Subject: MXC: mx31pdk: mc13783: Trying to full support mc13783 regulators
Message-ID: <1260470224.2141.37.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all! In those days I am trying to full support the i.MX31PDK board
in the mainline kernel.

I am facing an annoying problem with the MC13783 power management chip:
when i try to enable one digital output (GPOn) the system freezes!
I do not understand this behaviour, Freescale datasheet for mc13783
make no correlation between those digital output and other chip signals!

Another strange thing is that also enabling the GPO1, that following 
the board schematics, take the way to the connector without influencing
other components in the CPU Board, will get the system freeze!

Following there is a dump of all registers before the enabling GPO1 call
hangs the system:

mc13783-regulator mc13783-regulator: reg: 0, val: 0
mc13783-regulator mc13783-regulator: reg: 1, val: e9fffe
mc13783-regulator mc13783-regulator: reg: 2, val: 8d840
mc13783-regulator mc13783-regulator: reg: 3, val: 1
mc13783-regulator mc13783-regulator: reg: 4, val: ffffff
mc13783-regulator mc13783-regulator: reg: 5, val: 4838
mc13783-regulator mc13783-regulator: reg: 6, val: 9c46
mc13783-regulator mc13783-regulator: reg: 7, val: 9b
mc13783-regulator mc13783-regulator: reg: 8, val: 0
mc13783-regulator mc13783-regulator: reg: 9, val: 0
mc13783-regulator mc13783-regulator: reg: 10, val: 0
mc13783-regulator mc13783-regulator: reg: 11, val: 0
mc13783-regulator mc13783-regulator: reg: 12, val: 0
mc13783-regulator mc13783-regulator: reg: 13, val: 40
mc13783-regulator mc13783-regulator: reg: 14, val: 0
mc13783-regulator mc13783-regulator: reg: 15, val: 0
mc13783-regulator mc13783-regulator: reg: 16, val: 200000
mc13783-regulator mc13783-regulator: reg: 17, val: 0
mc13783-regulator mc13783-regulator: reg: 18, val: 0
mc13783-regulator mc13783-regulator: reg: 19, val: 0
mc13783-regulator mc13783-regulator: reg: 20, val: 10
mc13783-regulator mc13783-regulator: reg: 21, val: 1ffff
mc13783-regulator mc13783-regulator: reg: 22, val: 0
mc13783-regulator mc13783-regulator: reg: 23, val: 7fff
mc13783-regulator mc13783-regulator: reg: 24, val: 1c71d
mc13783-regulator mc13783-regulator: reg: 25, val: 1c71c
mc13783-regulator mc13783-regulator: reg: 26, val: 24924
mc13783-regulator mc13783-regulator: reg: 27, val: 24924
mc13783-regulator mc13783-regulator: reg: 28, val: 221605
mc13783-regulator mc13783-regulator: reg: 29, val: 3e1605
mc13783-regulator mc13783-regulator: reg: 30, val: 63eec
mc13783-regulator mc13783-regulator: reg: 31, val: b7c
mc13783-regulator mc13783-regulator: reg: 32, val: 6db65b
mc13783-regulator mc13783-regulator: reg: 33, val: 6db6d2
mc13783-regulator mc13783-regulator: reg: 34, val: 18000
mc13783-regulator mc13783-regulator: reg: 35, val: 0
mc13783-regulator mc13783-regulator: reg: 36, val: 1000
mc13783-regulator mc13783-regulator: reg: 37, val: d35a
mc13783-regulator mc13783-regulator: reg: 38, val: 420000
mc13783-regulator mc13783-regulator: reg: 39, val: 13060
mc13783-regulator mc13783-regulator: reg: 40, val: 180027
mc13783-regulator mc13783-regulator: reg: 41, val: e0004
mc13783-regulator mc13783-regulator: reg: 42, val: 0
mc13783-regulator mc13783-regulator: reg: 43, val: 8000
mc13783-regulator mc13783-regulator: reg: 44, val: 0
mc13783-regulator mc13783-regulator: reg: 45, val: ffffff
mc13783-regulator mc13783-regulator: reg: 46, val: 80
mc13783-regulator mc13783-regulator: reg: 47, val: 0
mc13783-regulator mc13783-regulator: reg: 48, val: 0
mc13783-regulator mc13783-regulator: reg: 49, val: e0060
mc13783-regulator mc13783-regulator: reg: 50, val: 6
mc13783-regulator mc13783-regulator: reg: 51, val: 0
mc13783-regulator mc13783-regulator: reg: 52, val: 0
mc13783-regulator mc13783-regulator: reg: 53, val: 0
mc13783-regulator mc13783-regulator: reg: 54, val: 0
mc13783-regulator mc13783-regulator: reg: 55, val: 0
mc13783-regulator mc13783-regulator: reg: 56, val: 0
mc13783-regulator mc13783-regulator: reg: 57, val: 0
mc13783-regulator mc13783-regulator: reg: 58, val: 0
mc13783-regulator mc13783-regulator: reg: 59, val: 0
mc13783-regulator mc13783-regulator: reg: 60, val: 0
mc13783-regulator mc13783-regulator: reg: 61, val: 0
mc13783-regulator mc13783-regulator: reg: 62, val: 0
mc13783-regulator mc13783-regulator: reg: 63, val: 0

Can you suggest me some kind of way to explain this?

The patches that follow this mail could take the current mxc-master
branch to mine.
Note that, especially the last patches are in development, so many
debug messages are enabled.

Alberto!
