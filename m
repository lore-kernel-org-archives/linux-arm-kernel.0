From: josh.coombs@gmail.com (Josh Coombs)
Date: Thu, 21 Jun 2012 08:08:36 -0400
Subject: [RFC PATCH] ARM: Initial DTS support for Kirkwood GoFlex Net
In-Reply-To: <CAMW5UfZ4YVj4DBiGDL6t2vRJEtUikOVS9kpGOCQqHuruxLzQmw@mail.gmail.com>
References: <20120619191820.GA28139@lunn.ch>
 <CAMW5UfZ4YVj4DBiGDL6t2vRJEtUikOVS9kpGOCQqHuruxLzQmw@mail.gmail.com>
Message-ID: <CAMW5UfYYuzjzh_PJapngtF-mBX8WX=orZw6Vzc5=tbA+FpWOTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some more test results:

Without the clock patch:
- No NAND definitions anywhere - doesn't complete a boot
- NAND defined and initialized in board-goflexnet.c - complete boot
with NAND accessible
- NAND defined via DT - doesn't complete a boot, stops at same point
as with no NAND definitions

With the clock patch, all combos work as you'd expect.

To move forward, do I assume the clock patch is going to be pulled
into mainline and submit my patch as depending on it, with NAND
defined in the DT, or for now submit with it defined and initialized
via the board file until the DT issue can be resolved?

Josh Coombs
